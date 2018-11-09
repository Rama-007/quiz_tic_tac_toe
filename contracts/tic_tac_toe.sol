pragma solidity ^0.4.22;
pragma experimental ABIEncoderV2;

contract tic_tac_toe
{
    int [3][3] board;
    mapping (address => bool) register_user;
    mapping(address => int) player;
    int player_count;
    int game_over;
    int turn;
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
        turn=0;
    }
    
    modifier onlyconductor()
    {
        require(msg.sender==conductor,"Only Conductor has access to this");
        _;
    }
    
    function game_not_over() public returns (bool)
    {
        for(uint i=0;i<3;i++)
        {
            if(board[i][0]==board[i][1] && board[i][1]==board[i][2])
            {
                return true;
            }
        }
        for(i=0;i<3;i++)
        {
            if(board[0][i]==board[1][i] && board[1][i]==board[2][i])
            {
                return true;
            }
        }
        if(board[0][0]==board[1][1] && board[1][1]==board[2][2])
        {
            return true;
        }
        if(board[0][2]==board[1][1] && board[1][1]==board[2][0])
        {
            return true;
        }
        return false;
    }
    
    function is_board_full() returns (bool)
    {
        for(uint i=0;i<3;i++)
        {
            for(uint j=0;j<3;j++)
            {
                if(board[i][j]==-1)
                    return false;
            }
        }
        return true;
    }
    
    function display_board() view public returns(int[3][3])
    {
        return board;
    }
    
    function register() public
    {
        require(player_count<2,"Game already started");
        require(msg.sender!=conductor,"conductor cant play");
        require(register_user[msg.sender]!=true,"already register");
        register_user[msg.sender]=true;
        player[msg.sender]=player_count;
        player_count++;
    }
    
    function play_game(uint xpos, uint ypos) public
    {
        require(msg.sender!=conductor,"conductor cant play");
        require(register_user[msg.sender]==true,"conductor cant play");
        require(is_board_full()==false,"board full");
        require(game_not_over()==false,"Game over");
        require(board[xpos][ypos]==-1,"already filled");
        require(turn%2==player[msg.sender]%2,"Other player turn");
        board[xpos][ypos]=player[msg.sender]%2;
        turn++;
    }
    
    function get_winner() view public returns (address)
    {
        require(game_not_over()==false || is_board_full()==true);
        
        
    }
    
    
    
}
