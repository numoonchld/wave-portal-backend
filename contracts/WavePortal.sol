// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    // uint256 totalWaves;
    mapping(address => uint256) private trackWaveCount;
    mapping(address => uint256) public lastWavedAt;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("We have been constructed!");
        seed = (block.timestamp * block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 24 hours < block.timestamp,
            "24-hr cool-down for this waver active!"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        // totalWaves += 1;
        // console.log("%s has waved!", msg.sender);
        console.log("%s waved with message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        trackWaveCount[msg.sender] += 1;

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        if (seed < 50) {
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more moneythan the contract has."
            );

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
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

    // receive() external payable {}
}
