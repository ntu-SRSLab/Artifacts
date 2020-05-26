
contract CryptoRomeAuction {

    // Reference to contract tracking NFT ownership
   

    uint256 public auctionStart;
    uint256 public startingPrice;
    uint256 public endingPrice;
    uint256 public auctionEnd;
    uint256 public extensionTime;
    uint256 public highestBid;
    address payable public  highestBidder;
    bytes32 public highestBidderCC;
    bool public highestBidIsCC;
    address payable public  paymentAddress;
    uint256 public tokenId;
    bool public ended;
    
    mapping(address=>uint) refunds;
    
    event Bid(address from, uint256 amount);
    constructor() public {
        // nonFungibleContract = ERC721(_nftAddress);
    }
    // msg_value < (highestBid+duration)
    // highestBid = msg_value
       // highestBid increase pattern 
    
    // highestBidder =  msg_sender
     function bid(address payable msg_sender, uint msg_value, uint msg_gas, uint block_timestamp) public payable{
        if (block_timestamp < auctionStart)
            // return;
            revert();
        if(block_timestamp >= auctionEnd)
            // return;
            revert();
        uint duration = 10000000000;
        // require(msg_value >= (highestBid + duration));
        if (msg_value < (highestBid + duration)){
            return;
            // revert();
        }
        if (highestBid != 0) {
            refunds[highestBidder] += highestBid;
        }

        if (block_timestamp > auctionEnd - extensionTime) {
            auctionEnd = block_timestamp + extensionTime;
        }

        highestBidder = msg_sender;
        highestBid = msg_value;
        highestBidIsCC = false;
        highestBidderCC = "";
        emit Bid(msg_sender, msg_value);
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

 

   function _Main_(address payable msg_sender1, uint p1, uint msg_value1, uint msg_gas1, uint block_timestamp1, address payable msg_sender2, uint p2, uint msg_value2, uint msg_gas2, uint block_timestamp2,address payable msg_sender3, uint p3, uint msg_value3, uint msg_gas3, uint block_timestamp3, address payable msg_sender4, uint p4, uint msg_value4, uint msg_gas4, uint block_timestamp4, address payable msg_sender5, uint p5, uint msg_value5, uint msg_gas5, uint block_timestamp5,address payable msg_sender6,uint p6, uint msg_value6, uint msg_gas6, uint block_timestamp6,address payable msg_sender7,uint p7, uint msg_value7, uint msg_gas7, uint block_timestamp7) public {
           require(!(msg_sender1==highestBidder || msg_sender2 == highestBidder || msg_sender3 == highestBidder|| msg_sender4 == highestBidder|| msg_sender5 == highestBidder|| msg_sender6 == highestBidder|| msg_sender7 == highestBidder));
           require(!(msg_sender1==msg_sender2 || msg_sender1 == msg_sender3 || msg_sender2 == msg_sender3));
           require(!(msg_sender4==msg_sender1 || msg_sender4 == msg_sender2 || msg_sender4 == msg_sender3));
           require(!(msg_sender5==msg_sender1 || msg_sender5 == msg_sender2 || msg_sender5 == msg_sender3||msg_sender5 == msg_sender4));
           require(!(msg_sender6==msg_sender1 || msg_sender6 == msg_sender2 || msg_sender6 == msg_sender3||msg_sender6 == msg_sender4||msg_sender6 == msg_sender5));
           require(!(msg_sender7==msg_sender1 || msg_sender7 == msg_sender2 || msg_sender7 == msg_sender3||msg_sender7 == msg_sender4||msg_sender7 == msg_sender5||msg_sender7 == msg_sender6));
           require(extensionTime > 0);
           require(highestBid==0);

           require(p1>100000000000 && p1< 200000000000);
           require(p2>100000000000 && p2< 200000000000);
           require(p3>100000000000 && p3< 200000000000);
           require(p4>100000000000 && p4< 200000000000);
           require(p5>100000000000 && p5< 200000000000);
           require(p6>100000000000 && p6< 200000000000);
           require(p7>100000000000 && p7< 200000000000);
           require(msg_value1>100000000000 && msg_value1< 200000000000);
           require(msg_value2>100000000000 && msg_value2< 200000000000);
           require(msg_value3>100000000000 && msg_value3< 200000000000);
           require(msg_value4>100000000000 && msg_value4< 200000000000);
           require(msg_value5>100000000000 && msg_value5< 200000000000);
           require(msg_value6>100000000000 && msg_value6< 200000000000);
           require(msg_value7>100000000000 && msg_value7< 200000000000);

           require(utilities[msg_sender1] == 0);
           require(utilities[msg_sender2] == 0);
           require(utilities[msg_sender3] == 0);
           require(utilities[msg_sender4] == 0);
           require(utilities[msg_sender5] == 0);
           require(utilities[msg_sender6] == 0);
           require(utilities[msg_sender7] == 0);
	   

           require(benefits[msg_sender1] == 0);
           require(benefits[msg_sender2] == 0);
           require(benefits[msg_sender3] == 0);
           require(benefits[msg_sender4] == 0);
           require(benefits[msg_sender5] == 0);
           require(benefits[msg_sender6] == 0);
           require(benefits[msg_sender7] == 0);

           require(payments[msg_sender1] == 0);
           require(payments[msg_sender2] == 0);
           require(payments[msg_sender3] == 0);
           require(payments[msg_sender4] == 0);
           require(payments[msg_sender5] == 0);
           require(payments[msg_sender6] == 0);
           require(payments[msg_sender7] == 0);

           //require(msg_value1!=p1);
           //require(msg_value2==p2);
           //require(msg_value3==p3);
           //require(msg_value4==p4);
           //require(msg_value5==p5);
           //require(msg_value6==p6);
           //require(msg_value7==p7);

           // each role claims the 'bid' action.
            bid(msg_sender1,msg_value1,msg_gas1,block_timestamp1);
            bid(msg_sender2,msg_value2,msg_gas2,block_timestamp2);
            bid(msg_sender3,msg_value3,msg_gas3,block_timestamp3);
            bid(msg_sender4,msg_value4,msg_gas4,block_timestamp4);
            bid(msg_sender5,msg_value5,msg_gas5,block_timestamp5);
            bid(msg_sender6,msg_value6,msg_gas6,block_timestamp6);
            bid(msg_sender7,msg_value7,msg_gas7,block_timestamp7);

            assert(msg_sender1 == highestBidder || msg_sender2 == highestBidder ||  msg_sender3 == highestBidder|| msg_sender4 == highestBidder || msg_sender5 == highestBidder || msg_sender6 == highestBidder|| msg_sender7 == highestBidder);

            uint  winners_count = 0;
            if ( msg_sender1 == highestBidder ){
                        sse_winner(msg_sender1);
                        winners_count ++;
                        utilities[msg_sender1] = p1 - msg_value1;
                        benefits[msg_sender1]  = p1;
                    }
            sse_utility(utilities[msg_sender1]);
            if ( msg_sender2 == highestBidder ){
                        sse_winner(msg_sender2);
                        winners_count ++;
                        utilities[msg_sender2] = p2 - msg_value2;
                        benefits[msg_sender2]  = p2;
            }
            sse_utility(utilities[msg_sender2]);
            if ( msg_sender3 == highestBidder ){
                        sse_winner(msg_sender3);
                        winners_count ++;
                        utilities[msg_sender3] = p3 - msg_value3;
                        benefits[msg_sender3]  = p3;
            }
            sse_utility(utilities[msg_sender3]);

            if ( msg_sender4 == highestBidder ){
                        sse_winner(msg_sender4);
                        winners_count ++;
                        utilities[msg_sender4] = p4 - msg_value4;
                        benefits[msg_sender4]  = p4;
            }
            sse_utility(utilities[msg_sender4]);
            if ( msg_sender5 == highestBidder ){
                        sse_winner(msg_sender5);
                        winners_count ++;
                        utilities[msg_sender5] = p5 - msg_value5;
                        benefits[msg_sender5]  = p5;
            }
            sse_utility(utilities[msg_sender5]);
            if ( msg_sender6 == highestBidder ){
                        sse_winner(msg_sender6);
                        winners_count ++;
                        utilities[msg_sender6] = p6 - msg_value6;
                        benefits[msg_sender6]  = p6;
            }
            sse_utility(utilities[msg_sender6]);
            if ( msg_sender7 == highestBidder ){
                        sse_winner(msg_sender7);
                        winners_count ++;
                        utilities[msg_sender7] = p7 - msg_value7;
                        benefits[msg_sender7]  = p7;
            }
            sse_utility(utilities[msg_sender7]);
	     uint expectation = benefits[msg_sender1]+benefits[msg_sender2]+benefits[msg_sender3]+benefits[msg_sender4]+benefits[msg_sender5]+benefits[msg_sender6]
+benefits[msg_sender7];
             sse_efficient_expectation_register(highestBidder, msg_sender1, p1);                                                                                                                       
             sse_efficient_expectation_register(highestBidder, msg_sender2, p2);
             sse_efficient_expectation_register(highestBidder, msg_sender3, p3);
             sse_efficient_expectation_register(highestBidder, msg_sender4, p4);
             sse_efficient_expectation_register(highestBidder, msg_sender5, p5);
             sse_efficient_expectation_register(highestBidder, msg_sender6, p6);
             sse_efficient_expectation_register(highestBidder, msg_sender7, p7);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender1);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender2);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender3);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender4);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender5);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender6);
             sse_efficient_violate_check(expectation,highestBidder,msg_sender7);
      }
}
