pragma solidity ^0.4.22;
pragma experimental ABIEncoderV2;

contract tic_tac_toe
{
    int [3][3] board;
    mapping (address => bool) register_user;
    mapping(address => uint) player;
    uint player_count;
    uint game_over;
    address conductor;
    
    constructor() payable
    {
        for(uint i=0;i<3;i++)
        {
            for(uint j=0;j<3;j++)
            {
                board[i][j]=-1;
            }
        }
        conductor=msg.sender;
        game_over=0;
        player_count=0;
    }
    
    modifier onlyconductor()
    {
        require(msg.sender==conductor,"Only Conductor has access to this");
        _;
    }
    
    function register() public
    {
        require(player_count<2,"Game already started");
        require(msg.sender!=conductor,"conductor cant play");
        require(register_user[msg.sender]!=true,"already register");
    }
    
    
}
