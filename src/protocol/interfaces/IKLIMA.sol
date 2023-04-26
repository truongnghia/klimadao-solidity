// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "oz/token/ERC20/utils/SafeERC20.sol";

interface IKlima is IERC20 {
    function mint(address account_, uint256 amount_) external;

    function burn(uint256 amount) external;

    function burnFrom(address account_, uint256 amount_) external;
}

interface IKlimaTreasury {
    function manage(address _token, uint _amount) external;

    function queue(uint8 _managing, address _address) external returns (bool);

    function toggle(uint8 _managing, address _address, address _calculator) external returns (bool);

    function ReserveManagerQueue(address _address) external returns (uint);
}

interface IKlimaRetirementBond {
    function owner() external returns (address);

    function DAO() external returns (address);

    function TREASURY() external returns (address);

    function fundMarket(address poolToken, uint256 amount) external;

    function updateMaxSlippage(address poolToken, uint256 _maxSlippage) external;

    function updateDaoFee(address poolToken, uint256 _daoFee) external;

    function setPoolReference(address poolToken, address referenceToken) external;
}