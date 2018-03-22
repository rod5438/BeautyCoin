//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
pragma solidity ^0.4.18;

contract ERC20Coin {
function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract PerfectOneToOne {
    address coinAddress;
    address perfectCorp;
    address BA;
    function PerfectOneToOne(address _perfectCorp, address _coinAddress) public {
        BA = msg.sender; // BA
        perfectCorp = _perfectCorp; // Perfect
        coinAddress = _coinAddress; // Beauty Coin
    } 
    function callPerfectBA(uint256 second) public {
        ERC20Coin beautyCoin = ERC20Coin(coinAddress);
        require(second > 1);
        require(beautyCoin.balanceOf(msg.sender) >= second);
        beautyCoin.transferFrom(msg.sender, BA, second -1);
        beautyCoin.transferFrom(msg.sender, perfectCorp, 1);
        // coinAddress.call(bytes4(bytes32(keccak256("transferFrom(address,address,uint256)"))), msg.sender, BA, second - 1);
        // coinAddress.call(bytes4(bytes32(keccak256("transferFrom(address,address,uint256)"))), msg.sender, perfectCorp, 1);
    }
}