// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";

contract ElectTokens is ERC20 {
    address public owner;
    

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }
    function decimals() public view virtual override returns (uint8) {
        return 6;
    }

    function mintTokens(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }
}


contract Emitter{
        using SafeMath for uint256;
        address public owner=msg.sender;
            modifier onlyOwner() {
            require(msg.sender == owner, "Only the owner can call this function");
            _;
    }

        address public usdtTokenAddress =0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
        ElectTokens public Milei = new ElectTokens("Milei", "MIL");
        ElectTokens public Bullrich = new ElectTokens("Bullrich", "BULL");
        ElectTokens public Massa = new ElectTokens("Massa", "MASS");
        ElectTokens public Larreta = new ElectTokens("Larreta", "LARR");
        ElectTokens public Otro = new ElectTokens("Otro", "OTR");
        ElectTokens winningOption;
        bool Stop;
        bool internal WinnerDetermined=false;
        uint256 ContractBalance=IERC20(usdtTokenAddress).balanceOf(address(this));
        string public winner;
        uint256 public rewardAmount;
        uint256 public rewardPerWinningBet;




    function mintToken1(address _token, uint256 amount) external {
        require(!Stop);
        amount=amount*10**6;
        IERC20(usdtTokenAddress).transferFrom(msg.sender, address(this), amount); // Transfer USD to contract
        ElectTokens(_token).mintTokens(amount);
        //IERC20(usdtTokenAddress).approve(address(this), amount);
        ElectTokens(_token).transfer(msg.sender, amount); // Transfer tokens to the caller
    }

    function determineWinners(ElectTokens _winningOption) external  onlyOwner {
        require(!WinnerDetermined);
        WinnerDetermined=true;
        winningOption=_winningOption;
        uint256 totalContractBalance = IERC20(usdtTokenAddress).balanceOf(address(this));
        uint256 totalWinningBets =winningOption.totalSupply();
        rewardPerWinningBet = totalContractBalance.div(totalWinningBets);
        winner=winningOption.name();
}  
    function ReceiveReward() external payable {
        require(winningOption.balanceOf(msg.sender)>0);
        require(WinnerDetermined);
        uint256 amount=winningOption.balanceOf(msg.sender);
        winningOption.transferFrom(msg.sender, address(this), amount);
        uint256 rewardAmount = (amount * rewardPerWinningBet)/1000000;
        IERC20(usdtTokenAddress).transfer(msg.sender, rewardAmount);
    }
    function Stop_Voting(bool _stop) internal onlyOwner {
        Stop=_stop;
    }

}

