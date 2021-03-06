pragma solidity ^0.4.22;
pragma experimental ABIEncoderV2;

contract tic_tac_toe
{
    int [3][3] board;
    mapping (address => bool) register_user;
    mapping(address => int) player;
    mapping(int => address) player_index;
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
            if(board[i][0]==board[i][1] && board[i][1]==board[i][2] && board[i][1]!=-1)
            {
                return true;
            }
        }
        for(i=0;i<3;i++)
        {
            if(board[0][i]==board[1][i] && board[1][i]==board[2][i] && board[1][i]!=-1)
            {
                return true;
            }
        }
        if(board[0][0]==board[1][1] && board[1][1]==board[2][2] && board[1][1]!=-1)
        {
            return true;
        }
        if(board[0][2]==board[1][1] && board[1][1]==board[2][0] && board[1][1]!=-1)
        {
            return true;
        }
        return false;
    }
    function winner() private returns (int)
    {
        for(uint i=0;i<3;i++)
        {
            if(board[i][0]==board[i][1] && board[i][1]==board[i][2] && board[i][1]!=-1)
            {
                return board[i][0];
            }
        }
        for(i=0;i<3;i++)
        {
            if(board[0][i]==board[1][i] && board[1][i]==board[2][i] && board[1][i]!=-1)
            {
                return board[0][i];
            }
        }
        if(board[0][0]==board[1][1] && board[1][1]==board[2][2] && board[1][1]!=-1)
        {
            return board[0][0];
        }
        if(board[0][2]==board[1][1] && board[1][1]==board[2][0] && board[1][1]!=-1)
        {
            return board[2][0];
        }
        return -1;
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
        player_index[player_count]=msg.sender;
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
    
    function toString(address x) private returns (string) {
    bytes memory b = new bytes(20);
    for (uint i = 0; i < 20; i++)
        b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
    return string(b);
    }
    
    function get_winner() view public returns (address)
    {
        require(msg.sender==conductor);
        require(game_not_over()==true || is_board_full()==true);
        int a=winner();
        if(a==-1)
            return conductor;
        for(int i=0;i<2;i++)
        {
            if(a==player[player_index[i]]%2)
            {
                return player_index[i];
            }
        }
    }
    
    
    
}
