// based on Bryn Bellomy code
// https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a
//
// updated to 0.4.21 standard, replaced blocks with time, converted to hot potato style by Chibi Fighters
// added custom start command for owner so they don't take off immidiately
//

pragma solidity >=0.4.21;

/**
* @title SafeMath
* @dev Math operations with safety checks that throw on error
*/
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256 ret) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256 ret) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
    * @dev Substracts two numbers, returns 0 if it would go into minus range.
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256 ret) {
        if (b >= a) {
            return 0;
        }
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256 ret) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract AuctionPotato {
    using SafeMath for uint256;
    // static
    address public owner;
    uint public startTime;
    uint public endTime;
    string name;

    // start auction manually at given time
    bool started;

    // pototo
    uint public potato;
    uint oldPotato;
    uint oldHighestBindingBid;

    // transfer ownership
    address creatureOwner;
    address creature_newOwner;
    event CreatureOwnershipTransferred(address indexed _from, address indexed _to);


    // state
    bool public canceled;

    uint public highestBindingBid;
    address public highestBidder;

    // used to immidiately block placeBids
    bool blockerPay;
    bool blockerWithdraw;

    mapping(address => uint256) public fundsByBidder;
    bool ownerHasWithdrawn;

    event LogBid(address bidder, address highestBidder, uint oldHighestBindingBid, uint highestBindingBid);
    event LogWithdrawal(address withdrawer, address withdrawalAccount, uint amount);
    event LogCanceled();


    // initial settings on contract creation
    constructor() public {

        blockerWithdraw = false;
        blockerPay = false;

        owner = msg.sender;
        creatureOwner = owner;

        // 0.01 ETH
        highestBindingBid = 10000000000000000;
        potato = 0;

        started = false;

        name = "Pixor";

    }

    function getHighestBid() internal
        view
        returns (uint ret)
    {
        return fundsByBidder[highestBidder];
    }

    // query remaining time
    // this should not be used, query endTime once and then calculate it in your frontend
    // it's helpful when you want to debug in remix
    function timeLeft() public view returns (uint time) {
        if (now >= endTime) return 0;
        return endTime - now;
    }

    function auctionName() public view returns (string memory _name) {
        return name;
    }

    // calculates the next bid amount to you can have a oneclick buy button
    function nextBid() public view returns (uint _nextBid) {
        return highestBindingBid.add(potato);
    }

    // calculates the bid after the current bid so nifty hackers can skip the queue
    // this is not in our frontend and no one knows if it actually works
    function nextNextBid() public view returns (uint _nextBid) {
        return highestBindingBid.add(potato).add((highestBindingBid.add(potato)).mul(4).div(9));
    }

    // command to start the auction
    function startAuction(string memory _name, uint _duration_secs) public onlyOwner returns (bool success){
        require(started == false);

        started = true;
        startTime = now;
        endTime = now + _duration_secs;
        name = _name;

        return true;

    }

    function isStarted() public view returns (bool success) {
        return started;
    }

    function placeBid() public
        payable
        onlyAfterStart
        onlyBeforeEnd
        onlyNotCanceled
        onlyNotOwner
        returns (bool success)
    {
        // we are only allowing to increase in bidIncrements to make for true hot potato style
        require(msg.value == highestBindingBid.add(potato));
        require(msg.sender != highestBidder);
        require(started == true);
        require(blockerPay == false);
        blockerPay = true;

        // calculate the user's total bid based on the current amount they've sent to the contract
        // plus whatever has been sent with this transaction

        fundsByBidder[msg.sender] = fundsByBidder[msg.sender].add(highestBindingBid);
        fundsByBidder[highestBidder] = fundsByBidder[highestBidder].add(potato);

        oldHighestBindingBid = highestBindingBid;

        // set new highest bidder
        highestBidder = msg.sender;
        highestBindingBid = highestBindingBid.add(potato);

        // 40% potato results in ~6% 2/7
        // 44% potato results in ? 13% 4/9
        // 50% potato results in ~16% /2
        oldPotato = potato;
        potato = highestBindingBid.mul(5).div(9);

        emit LogBid(msg.sender, highestBidder, oldHighestBindingBid, highestBindingBid);
        blockerPay = false;
        return true;
    }

    function cancelAuction() public
        onlyOwner
        onlyBeforeEnd
        onlyNotCanceled
        returns (bool success)
    {
        canceled = true;
        emit LogCanceled();
        return true;
    }

    function withdraw() public
    // can withdraw once overbid
        returns (bool success)
    {
        require(blockerWithdraw == false);
        blockerWithdraw = true;

        address withdrawalAccount;
        uint withdrawalAmount;

        if (canceled) {
            // if the auction was canceled, everyone should simply be allowed to withdraw their funds
            withdrawalAccount = msg.sender;
            withdrawalAmount = fundsByBidder[withdrawalAccount];
            // set funds to 0
            fundsByBidder[withdrawalAccount] = 0;
        }

        // owner can withdraw once auction is cancelled or ended
        if (ownerHasWithdrawn == false && msg.sender == owner && (canceled == true || now > endTime)) {
            withdrawalAccount = owner;
            withdrawalAmount = highestBindingBid.sub(oldPotato);
            ownerHasWithdrawn = true;

            // set funds to 0
            fundsByBidder[withdrawalAccount] = 0;
        }

        // overbid people can withdraw their bid + profit
        // exclude owner because he is set above
        if (!canceled && (msg.sender != highestBidder && msg.sender != owner)) {
            withdrawalAccount = msg.sender;
            withdrawalAmount = fundsByBidder[withdrawalAccount];
            fundsByBidder[withdrawalAccount] = 0;
        }

        // highest bidder can withdraw leftovers if he didn't before
        if (!canceled && msg.sender == highestBidder && msg.sender != owner) {
            withdrawalAccount = msg.sender;
            withdrawalAmount = fundsByBidder[withdrawalAccount].sub(oldHighestBindingBid);
            fundsByBidder[withdrawalAccount] = fundsByBidder[withdrawalAccount].sub(withdrawalAmount);
        }

        if (withdrawalAmount == 0) revert();

        // send the funds
        msg.sender.transfer(withdrawalAmount);

        emit LogWithdrawal(msg.sender, withdrawalAccount, withdrawalAmount);
        blockerWithdraw = false;
        return true;
    }

    // amount owner can withdraw after auction ended
    // that way you can easily compare the contract balance with your amount
    // if there is more in the contract than your balance someone didn't withdraw
    // let them know that :)
    function ownerCanWithdraw() public view returns (uint amount) {
        return highestBindingBid.sub(oldPotato);
    }

    // just in case the contract is bust and can't pay
    // should never be needed but who knows
    function fuelContract() public onlyOwner payable {

    }

    function balance() public view returns (uint _balance) {
        return address(this).balance;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyNotOwner {
        require(msg.sender != owner);
        _;
    }

    modifier onlyAfterStart {
        if (now < startTime) revert();
        _;
    }

    modifier onlyBeforeEnd {
        if (now > endTime) revert();
        _;
    }

    modifier onlyNotCanceled {
        if (canceled) revert();
        _;
    }

    // who owns the creature (not necessarily auction winner)
    function queryCreatureOwner() public view returns (address _creatureOwner) {
        return creatureOwner;
    }

    // transfer ownership for auction winners in case they want to trade the creature before release
    function transferCreatureOwnership(address _newOwner) public {
        require(msg.sender == creatureOwner);
        creature_newOwner = _newOwner;
    }

    // buyer needs to confirm the transfer
    function acceptCreatureOwnership() public {
        require(msg.sender == creature_newOwner);
        emit CreatureOwnershipTransferred(creatureOwner, creature_newOwner);
        creatureOwner = creature_newOwner;
        creature_newOwner = address(0);
    }
    
    function bid(address payable msg_sender, uint msg_value) public {
        // we are only allowing to increase in bidIncrements to make for true hot potato style
        // require(msg_value == highestBindingBid+potato);
        if(msg_value != highestBindingBid+potato)return;
        // require(msg_sender != highestBidder);
        require(started == true);
        require(blockerPay == false);
        blockerPay = true;

        // calculate the user's total bid based on the current amount they've sent to the contract
        // plus whatever has been sent with this transaction

        fundsByBidder[msg_sender] = fundsByBidder[msg_sender] + highestBindingBid;
        fundsByBidder[highestBidder] = fundsByBidder[highestBidder] + potato;

        oldHighestBindingBid = highestBindingBid;

        // set new highest bidder
        highestBidder = msg_sender;
        highestBindingBid = highestBindingBid + potato;

        // 40% potato results in ~6% 2/7
        // 44% potato results in ? 13% 4/9
        // 50% potato results in ~16% /2
        oldPotato = potato;
        potato = highestBindingBid*5/9;

        emit LogBid(msg.sender, highestBidder, oldHighestBindingBid, highestBindingBid);
        blockerPay = false;
        return;
    }

    mapping(address=>uint) utilities;
    mapping(address=>uint) benefits;
    mapping(address=>uint) payments;
    function sse_winner(address a) public view {}
    function sse_revenue(uint a) public view {}
    function sse_utility(uint a) public view {}
    function sse_maximize(uint a) public view {}
    function sse_minimize(uint a) public view {}
    function sse_truthful_violate_check(uint u, uint a, uint b) public view {}
    function sse_collusion_violate_check(uint u12, uint v1, uint v_1, uint v2, uint v_2) public view{}
    function sse_efficient_expectation_register(address allocation, address player, uint benefit) public view {}
    function sse_efficient_violate_check(uint benefit, address allocation, address other_allocation) public view {}
    function sse_optimal_payment_register(address allocation, address player, uint payment) public view {}
    function sse_optimal_violate_check(uint benefit, address allocation, address other_allocation) public view {}

 
   function _Main_(address payable msg_sender1, uint p1, uint msg_value1, uint msg_gas1, uint block_timestamp1, address payable msg_sender2, uint p2, uint msg_value2, uint msg_gas2, uint block_timestamp2,address payable msg_sender3, uint p3, uint msg_value3, uint msg_gas3, uint block_timestamp3) public {
           require(!(msg_sender1==highestBidder || msg_sender2 == highestBidder || msg_sender3 == highestBidder));
           require(!(msg_sender1==msg_sender2 || msg_sender1 == msg_sender3 || msg_sender2 == msg_sender3));
           require(highestBindingBid==0);
           require(potato==120000000000);
           require(fundsByBidder[msg_sender1] == 0);
           require(fundsByBidder[msg_sender2] == 0);
           require(fundsByBidder[msg_sender3] == 0);

           require(p1>100000000000 && p1< 900000000000);
           require(p2>100000000000 && p2< 900000000000);
           require(p3>100000000000 && p3< 900000000000);
           require(msg_value1>100000000000 && msg_value1< 900000000000);
           require(msg_value2>100000000000 && msg_value2< 900000000000);
           require(msg_value3>100000000000 && msg_value3< 900000000000);

           require(utilities[msg_sender1] == 0);
           require(utilities[msg_sender2] == 0);
           require(utilities[msg_sender3] == 0);

           require(benefits[msg_sender1] == 0);
           require(benefits[msg_sender2] == 0);
           require(benefits[msg_sender3] == 0);

           require(payments[msg_sender1] == 0);
           require(payments[msg_sender2] == 0);
           require(payments[msg_sender3] == 0);

        //    require(msg_value1!=p1);
           require(msg_value2==p2);
           require(msg_value3==p3);

           // each role claims the 'bid' action.
            bid(msg_sender1,msg_value1);
            bid(msg_sender2,msg_value2);
            bid(msg_sender3,msg_value3);

              // assert(msg_sender3 == highestBidder);
            assert(msg_sender1 == highestBidder || msg_sender2 == highestBidder ||  msg_sender3 == highestBidder );

            uint  winners_count = 0;
            if ( msg_sender1 == highestBidder ){
                        sse_winner(msg_sender1);
                        winners_count ++;
                        utilities[msg_sender1] = p1 - msg_value1;
                        benefits[msg_sender1]  = p1;
                        payments[msg_sender1]  = msg_value1;
                    }
            sse_utility(utilities[msg_sender1]);
            if ( msg_sender2 == highestBidder ){
                        sse_winner(msg_sender2);
                        winners_count ++;
                        utilities[msg_sender2] = p2 - msg_value2;
                        benefits[msg_sender2]  = p2;
                        payments[msg_sender2]  = msg_value2;
            }
            sse_utility(utilities[msg_sender2]);
            if ( msg_sender3 == highestBidder ){
                        sse_winner(msg_sender3);
                        winners_count ++;
                        utilities[msg_sender3] = p3 - msg_value3;
                        benefits[msg_sender3]  = p3;
                        payments[msg_sender3]  = msg_value3;
            }
            sse_utility(utilities[msg_sender3]);

            sse_truthful_violate_check(utilities[msg_sender1],msg_value1, p1);
     
      }
}