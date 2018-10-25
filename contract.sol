pragma solidity ^0.4.25;

// This is incomplete and probably buggy

contract HawkDoveBet {
    
    address public person1;
    address public person2;
    address public owner;
    uint256 betAmount;
    uint256 stakeAmount;
    uint256 deadline;
    bool inGame;
    
    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public didWin;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyPlayer {
        require(msg.sender == person1 || msg.sender == person2);
        _;
    }
    
    modifier onlyInGame {
        require(inGame == true);
        _;
    }
    
    modifier onlyBeforeDeadline {
        require(now < deadline);
        _;
    }
    
    modifier onlyAfterDeadline {
        require(now >= deadline);
        _;
    }
    
    constructor(
        address _person1,
        address _person2,
        uint256 _betAmount,
        uint256 _stakeAmount,
        uint256 _deadlineHours
        ) public {
            owner = msg.sender;
            person1 = _person1;
            person2 = _person2;
            betAmount = _betAmount * 1 finney;
            stakeAmount = _stakeAmount * 1 finney;
            deadline = now + _deadlineHours * 1 hours;
        }
    
    function addFunds() onlyPlayer payable public {
        require(msg.value > 0);
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
    }
    
    function beginGame() onlyPlayer public {
        uint totalAmount = betAmount + stakeAmount;
        require(balanceOf[person1] >= totalAmount && balanceOf[person2] >= totalAmount);
        inGame = true;
    }
    
    function iWin() onlyPlayer onlyInGame public {
        didWin[msg.sender] = true;
    }
    
    function iLose() onlyPlayer onlyInGame public {
        didWin[msg.sender] = false;
    }
    
    function settleGame() 
    
    
}
