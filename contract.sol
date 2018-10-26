pragma solidity ^0.4.25;

contract HawkDoveBet {
    
    address public person1;
    address public person2;
    address public owner;
    uint256 public betAmount;
    uint256 public stakeAmount;
    uint256 private totalAmount;
    uint256 public deadline;
    bool public inGame;
    address private myAddress = this;
    address private burnAddress = 0x0000000000000000000000000000000000000000;
    
    // Mapping to keep track of players' respective balances
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
        require(inGame);
        _;
    }
    modifier onlyNotInGame {
        require(!inGame);
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
            totalAmount = betAmount + stakeAmount;
            deadline = now + _deadlineHours * 1 hours;
        }
    
    function addFunds() onlyPlayer payable public {
        require(msg.value > 0);
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
    }
    
    function beginGame() onlyPlayer public {
        //uint totalAmount = betAmount + stakeAmount;
        require(balanceOf[person1] >= totalAmount && balanceOf[person2] >= totalAmount);
        inGame = true;
    }
    
    // A player declares victory. Only allowed during game and before deadline
    function iWin() onlyPlayer onlyInGame onlyBeforeDeadline public {
        didWin[msg.sender] = true;
    }
    
    // A player declares a loss. Only allowed during game and before deadline
    function iLose() onlyPlayer onlyInGame onlyBeforeDeadline public {
        didWin[msg.sender] = false;
    }
    
    function settleGame() onlyAfterDeadline onlyInGame public {
        if (didWin[person1] != didWin[person2]) {
            if (didWin[person1]) {      //If p1 won, update bal
                balanceOf[person1] += betAmount;
                balanceOf[person2] -= betAmount;
                inGame = false;
            } else {                    //If p2 won, update bal
                balanceOf[person2] += betAmount;
                balanceOf[person1] -= betAmount;
                inGame = false;
            }
        } else if (!didWin[person1]) {  //If no winner, end game
            inGame = false;
        } else {                        //If both claim win, burn
            uint burnAmount = totalAmount * 2;
            burnAddress.transfer(burnAmount);
            balanceOf[person1] -= totalAmount;
            balanceOf[person2] -= totalAmount;
            inGame = false;
        }
    }
    
    function withdrawBalance() onlyPlayer onlyNotInGame public {
        require(balanceOf[msg.sender] > 0);
        uint tempBal = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(tempBal);
    }
    
}
