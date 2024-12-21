// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  mapping(address => uint256) public balances;
  uint256 public constant threshold = 1 ether;
  uint256 public deadline = block.timestamp +  72 hours;
  bool openToWithdraw = false;

  event Stake(address,uint256);

  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  // Collect funds in a payable `stake()` function and track individual `balancess` with a mapping:
  // (Make sure to add a `Stake(address,uint256)` event and emit it for the frontend `All Stakings` tab to display)

      function stake() payable public  {
        balances[msg.sender] += msg.value;
        emit Stake(msg.sender, msg.value);
      }


  // After some `deadline` allow anyone to call an `execute()` function
  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balances}()`

    function execute() notCompleted public {
      require(block.timestamp > deadline);
      require(openToWithdraw == false);
      bool isOverThreshold =  address(this).balance > threshold;
      if(isOverThreshold){
       exampleExternalContract.complete{value: address(this).balance}();
      } else{
          openToWithdraw = true;
      }
    }
    
 

  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balances
     function withdraw() notCompleted public {
      require(openToWithdraw);
       payable(msg.sender).transfer(balances[msg.sender]);
       balances[msg.sender] = 0;
    }


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend

  function timeLeft () public view returns (uint256){
    if(block.timestamp >= deadline){
      return 0;
    }else{
      return deadline - block.timestamp;
    }
  }


  // Add the `receive()` special function that receives eth and calls stake()
    receive()  external payable {
      stake();
    }

    modifier notCompleted {
      require(exampleExternalContract.completed() ==  false);
      _;
    }
}
