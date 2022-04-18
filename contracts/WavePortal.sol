// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) trackWaveCount;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        trackWaveCount[msg.sender] += 1;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWaveCount(address interactor) public view returns (uint256) {
        console.log(
            "%s has waved %d time(s)!",
            interactor,
            trackWaveCount[interactor]
        );
        return trackWaveCount[interactor];
    }
}
