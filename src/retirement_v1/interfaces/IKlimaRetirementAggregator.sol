// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IKlimaRetirementAggregator {
    function KLIMA() external pure returns (address);

    function sKLIMA() external pure returns (address);

    function wsKLIMA() external pure returns (address);

    function USDC() external pure returns (address);

    function staking() external pure returns (address);

    function stakingHelper() external pure returns (address);

    function klimaRetirementStorage() external pure returns (address);

    function treasury() external pure returns (address);

    function retireCarbonSpecific(
        address _sourceToken,
        address _poolToken,
        uint256 _amount,
        bool _amountInCarbon,
        address _beneficiaryAddress,
        string memory _beneficiaryString,
        string memory _retirementMessage,
        address[] memory _carbonList
    ) external;
}
