analyzing contract [ Rewrite ]
exit contract [ Rewrite ]
analyzing contract [ Rewrite ]
exit contract [ Rewrite ]
state variables: 
	varName: benefits@107, value: benefits@107_0_, sort: (Array String Int)
	varName: utilities@103, value: utilities@103_0_, sort: (Array String Int)
	varName: msg.value, value: msg.value_0_, sort: Int
	varName: msg.sender, value: msg.sender_0_, sort: String
	varName: voteCount@4, value: voteCount@4_0_, sort: (Array Int Int)
	varName: block.timestamp, value: block.timestamp_0_, sort: Int
	varName: this.balance, value: this.balance_0_, sort: Int
	varName: proposals@10, value: proposals@10_0_, sort: (Array Int Proposal)
local variables: 
	varName: msg_value5@241, value: msg_value5@241_0_, sort: Bool
	varName: p5_rv_value@239, value: p5_rv_value@239_0_, sort: Int
	varName: p5_value@237, value: p5_value@237_0_, sort: Int
	varName: p5@235, value: p5@235_0_, sort: Bool
	varName: msg_value4@231, value: msg_value4@231_0_, sort: Bool
	varName: p4_rv_value@229, value: p4_rv_value@229_0_, sort: Int
	varName: p4_value@227, value: p4_value@227_0_, sort: Int
	varName: msg_value3@221, value: msg_value3@221_0_, sort: Bool
	varName: msg_sender4@223, value: msg_sender4@223_0_, sort: String
	varName: p3_value@217, value: p3_value@217_0_, sort: Int
	varName: p3@215, value: p3@215_0_, sort: Bool
	varName: msg_sender3@213, value: msg_sender3@213_0_, sort: String
	varName: msg_value2@211, value: msg_value2@211_0_, sort: Bool
	varName: p2_rv_value@209, value: p2_rv_value@209_0_, sort: Int
	varName: a@127, value: a@127_0_, sort: Int
	varName: msg_sender1@193, value: msg_sender1@193_0_, sort: String
	varName: p2_value@207, value: p2_value@207_0_, sort: Int
	varName: a@141, value: a@141_0_, sort: Bool
	varName: v_2@157, value: v_2@157_0_, sort: Bool
	varName: a@109, value: a@109_0_, sort: String
	varName: p1@195, value: p1@195_0_, sort: Bool
	varName: a@121, value: a@121_0_, sort: Int
	varName: u12@149, value: u12@149_0_, sort: Int
	varName: winner@371, value: winner@371_0_, sort: Int
	varName: v2@155, value: v2@155_0_, sort: Bool
	varName: msg_sender5@233, value: msg_sender5@233_0_, sort: String
	varName: a@115, value: a@115_0_, sort: Int
	varName: benefit@173, value: benefit@173_0_, sort: Int
	varName: i@67, value: i@67_0_, sort: Int
	varName: v1@151, value: v1@151_0_, sort: Bool
	varName: a@133, value: a@133_0_, sort: Int
	varName: allocation@185, value: allocation@185_0_, sort: String
	varName: numberOfProposal@12, value: numberOfProposal@12_0_, sort: Int
	varName: other_allocation@177, value: other_allocation@177_0_, sort: Bool
	varName: p3_rv_value@219, value: p3_rv_value@219_0_, sort: Int
	varName: success@39, value: success@39_0_, sort: Bool
	varName: winnerName@57, value: winnerName@57_0_, sort: Int
	varName: maxVotes@60, value: maxVotes@60_0_, sort: Int
	varName: u@139, value: u@139_0_, sort: Int
	varName: b@143, value: b@143_0_, sort: Bool
	varName: allocation@163, value: allocation@163_0_, sort: Bool
	varName: winner@64, value: winner@64_0_, sort: Int
	varName: v_1@153, value: v_1@153_0_, sort: Bool
	varName: p4@225, value: p4@225_0_, sort: Bool
	varName: other_allocation@165, value: other_allocation@165_0_, sort: Bool
	varName: g_false@490, value: g_false@490_0_, sort: Int
	varName: proposalNum@36, value: proposalNum@36_0_, sort: Int
	varName: other_allocation@187, value: other_allocation@187_0_, sort: String
	varName: benefit@167, value: benefit@167_0_, sort: Int
	varName: allocation@175, value: allocation@175_0_, sort: Bool
	varName: benefit@183, value: benefit@183_0_, sort: Int
	varName: p1_value@197, value: p1_value@197_0_, sort: Int
	varName: msg_value1@201, value: msg_value1@201_0_, sort: Bool
	varName: p2@205, value: p2@205_0_, sort: Bool
	varName: p1_rv_value@199, value: p1_rv_value@199_0_, sort: Int
	varName: msg_sender2@203, value: msg_sender2@203_0_, sort: String
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symbolically execute function [_Main_]
Using Z3 solver to optimize value expression
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--------------------------------OUTCOME-------------------------------------
|truthful violate check        |value                                   |
-------------------------------------------------------------------------
|collusion violate check       |value                                   |
-------------------------------------------------------------------------
|effecient violate check       |value                                   |
-------------------------------------------------------------------------
|utilities[msg_sender1] +
                                        utilities[msg_sender2] + utilities[msg_sender3] + 
                                        utilities[msg_sender4] + utilities[msg_sender5]|Uneffecient                             |
-------------------------------------------
|Uneffecient Case                         |
-------------------------------------------
----------------State Variable-----------------------
|name                |value               |
|utilities           |(let ((a!1 (store (store (store ((as const (Array String Int)) 7) "!2!" 0)
                         "!0!"
                         0)
                  "!3!"
                  0)))
(let ((a!2 (store (store (store (store a!1 "!1!" 0) "!4!" 0) "!0!" 1) "!1!" 1)))
  (store (store (store a!2 "!2!" 1) "!3!" 1) "!4!" 1)))|
|proposals           |2                   |
|voteCount           |voteCount@4_0_.length|
----------------Local Variable-----------------------
|msg_value5          |false               |
|p5_rv_value         |0                   |
|p5_value            |1                   |
|p5                  |false               |
|msg_value4          |true                |
|p4_rv_value         |0                   |
|p4_value            |1                   |
|msg_value3          |true                |
|msg_sender4         |"!3!"               |
|p3_value            |1                   |
|p3                  |false               |
|msg_sender3         |"!2!"               |
|msg_value2          |true                |
|p2_rv_value         |0                   |
|msg_sender1         |"!0!"               |
|p2_value            |1                   |
|p1                  |false               |
|winner              |0                   |
|msg_sender5         |"!4!"               |
|i                   |2                   |
|numberOfProposal    |2                   |
|p3_rv_value         |0                   |
|success             |true                |
|winnerName          |0                   |
|maxVotes            |5                   |
|winner              |0                   |
|p4                  |false               |
|g_false             |0                   |
|proposalNum         |0                   |
|p1_value            |1                   |
|msg_value1          |true                |
|p2                  |false               |
|p1_rv_value         |0                   |
|msg_sender2         |"!1!"               |
-------------------------------------------

|utilities                     |value                                   |
-------------------------------------------------------------------------
|utilities[msg_sender1]        |1                                       |
-------------------------------------------------------------------------
|utilities[msg_sender2]        |1                                       |
-------------------------------------------------------------------------
|utilities[msg_sender3]        |1                                       |
-------------------------------------------------------------------------
|utilities[msg_sender4]        |1                                       |
-------------------------------------------------------------------------
|utilities[msg_sender5]        |1                                       |
-------------------------------------------------------------------------
|revenue                       |value                                   |
-------------------------------------------------------------------------

|winner                        |value                                   |
-------------------------------------------------------------------------

hint
benefit:5
optional benefit:0
-------------------------------------------------------------------------
|optimal violate check         |value                                   |
**************************************
*    outcome pattern                 *
**************************************
*************************************
*         report                    *
*************************************
* model construction time: 161.822s
*  property checking time: 0.725s
*              total time: 162.547s
*  pattern [ fairness:(contexts)-(violates) ] 
*      truthful:1024-0
*collusion-free:1024-0
*       optimal:1024-0
*     efficient:1024-1
*************************************
