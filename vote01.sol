// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract vote01{
    string[] cadidation;
    string[] voter;
    mapping(uint => bool) check;
    mapping(string => uint) vote_count;
    mapping(string => uint) cadidate_name;
    mapping(uint => uint) voter_name;
    address private owner = msg.sender;

    //統計回報系統
    function count(string memory name) public view returns (uint){
            return vote_count[name];
    } 


    //輸入參與（學號，生日）
    function voting(uint password, string memory _cadidate_name) public returns(string memory){
        if(check[password]== false && voter_name[password]==1){
            if(cadidate_name[_cadidate_name]==1){
                vote_count[_cadidate_name] += 1;
                check[password] = true;
                return "Complete!";
            }
            else{
                return "Error name";
            }
        }
        else{
            return "Error password or have been voted.";
        }
    }

    //候選人名單匯入
    function cadidation_add(string memory _cadidation) public {
        require(msg.sender == owner);
        cadidation.push(_cadidation);
        cadidate_name[_cadidation] = 1;
    }

    //清除候選人名單
    function cadidation_clear() public {
        require(msg.sender == owner);
        while(cadidation.length>0){
            delete cadidate_name[cadidation[cadidation.length-1]];
            delete vote_count[cadidation[cadidation.length-1]];
            cadidation.pop();
        }
    }

    //投票人名單匯入
    function voter_add(string memory _voter, uint password) public {
        require(msg.sender == owner);
        voter_name[password] = 1;
        voter.push(_voter);
    }    
}