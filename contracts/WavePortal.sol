// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    // uint256 totalWaves;
    mapping(address => uint256) trackWaveCount;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("We have been constructed!");
    }

    function wave(string memory _message) public {
        // totalWaves += 1;
        // console.log("%s has waved!", msg.sender);
        console.log("%s waved with message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        trackWaveCount[msg.sender] += 1;

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more moneythan the contract has."
        );

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract");
    }

    function getTotalWaves() public view returns (uint256) {
        // console.log("We have %d total waves!", totalWaves);
        // return totalWaves;
        return waves.length;
    }

    function getWaveCount(address interactor) public view returns (uint256) {
        console.log(
            "%s has waved %d time(s)!",
            interactor,
            trackWaveCount[interactor]
        );
        return trackWaveCount[interactor];
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    receive() external payable {}
}
