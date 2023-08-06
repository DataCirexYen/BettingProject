# BettingProject
ElectTokens is a  voting protocol built on the Ethereum blockchain, allowing users to vote for different political options represented by ERC20 tokens. The project aims to promote community engagement and incentivize participation by rewarding users with tokens based on their winning bets.

## Functions
### mintToken1: 
A function that allows users to vote for their preferred political option. Users send USDT to the contract, and in return, they receive ERC20 tokens corresponding to their chosen option.

### determineWinners: 
This function is called by the owner (election organizer) to determine the winning political option. It calculates the total contract balance and the total supply of tokens for the winning option to distribute rewards later.

### ReceiveReward: 
Participants can claim their rewards in USDT tokens by calling this function after the winning option has been determined. The contract calculates the reward amount based on the number of tokens the participant holds for the winning option and the total reward pool.

### Stop_Voting: 
Only the owner can call this function to stop further voting and ensure the determination of winners is final.

**Note**: The provided code is a simplified example, and in a real-world scenario, additional security measures, testing, and proper **handling of rewards distribution** should be implemented.
