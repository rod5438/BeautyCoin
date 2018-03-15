//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
pragma solidity ^0.4.18;
contract BeautyCoin {

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    function name() public pure returns (string) {
        return "Beauty coin";
    }

    function symbol() public pure returns (string) {
        return "BTC";
    }

    function decimals() public pure returns (uint8) {
        return 0;
    }

    function BuyBeautyCoin() public payable {
        balances[msg.sender] += msg.value * 1000; // WEIBTC
    }

    function SellBeautyCoin(uint256 BTC) public {
        uint256 WEIBTC = BTC * 10**18;
        require(WEIBTC <= balances[msg.sender]);
        balances[msg.sender] -= WEIBTC;
        msg.sender.transfer(WEIBTC / 1000);
    }

    // 1 ehter is 10^18 WEI
    // 1 BTC is 10^18 WEIBTC
    // 1000 WEIBTC = WEI
    // 1000 BTC = 1 ether 
    function totalSupply() public view returns (uint256) {
        return this.balance * 1000;
    }
  
    function transfer(address _to, uint256 BTC) public returns (bool) {
        require(_to != address(0));
        uint256 WEIBTC = BTC * 10**18;
        require(WEIBTC <= balances[msg.sender]);

         // SafeMath.sub will throw if there is not enough balance.
        balances[msg.sender] = balances[msg.sender] - WEIBTC;
        balances[_to] = balances[_to] + WEIBTC;
        Transfer(msg.sender, _to, BTC);
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transferFrom(address _from, address _to, uint256 BTC) public returns (bool) {
        require(_to != address(0));
        uint256 WEIBTC = BTC * 10**18;
        require(WEIBTC <= balances[_from]);
        require(WEIBTC <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from] - WEIBTC;
        balances[_to] = balances[_to] + WEIBTC;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - WEIBTC;
        Transfer(_from, _to, BTC);
        return true;
    }

    function approve(address _spender, uint256 BTC) public returns (bool) {
        uint256 WEIBTC = BTC * 10**18;
        allowed[msg.sender][_spender] = WEIBTC;
        Approval(msg.sender, _spender, BTC);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    event Transfer(address indexed from, address indexed to, uint256 BTC);
    event Approval(address indexed owner, address indexed spender, uint256 BTC);
}