// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Cujo <rawr@cujowolf.dev>

* Script to deploy Retirement Aggregator V1 as Transparent Proxies.
/******************************************************************************/

import "forge-std/Script.sol";

import "oz/proxy/transparent/TransparentUpgradeableProxy.sol";
import "oz/proxy/transparent/ProxyAdmin.sol";

import {KlimaCarbonRetirements} from "../src/retirement_v1/KlimaCarbonRetirements.sol";
import {KlimaRetirementAggregator} from "../src/retirement_v1/KlimaRetirementAggregator.sol";
import {RetireMossCarbon} from "../src/retirement_v1/RetireMossCarbon.sol";
import {RetireToucanCarbon} from "../src/retirement_v1/RetireToucanCarbon.sol";
import {RetireC3Carbon} from "../src/retirement_v1/RetireC3Carbon.sol";

contract DeployRetirementV1 is Script {
    ProxyAdmin admin;

    // KlimaCarbonRetirements retireStorage;

    KlimaRetirementAggregator masterImplementation;
    // TransparentUpgradeableProxy masterProxy;
    KlimaRetirementAggregator wrappedMasterProxy;

    RetireMossCarbon mossImplementation;
    TransparentUpgradeableProxy mossProxy;
    RetireMossCarbon wrappedMossProxy;

    RetireToucanCarbon toucanImplementation;
    TransparentUpgradeableProxy toucanProxy;
    RetireToucanCarbon wrappedToucanProxy;

    RetireC3Carbon c3Implementation;

    // TransparentUpgradeableProxy c3Proxy;
    // RetireC3Carbon wrappedC3Proxy;

    function run() external {
        //read env variables and choose EOA for transaction signing
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address masterAddress = vm.envAddress("RETIREMENT_V1_ADDRESS");
        address adminAddress = vm.envAddress("PROXY_ADMIN_V1");

        vm.startBroadcast(deployerPrivateKey);

        wrappedMasterProxy = KlimaRetirementAggregator(masterAddress);

        admin = ProxyAdmin(adminAddress);

        mossImplementation = new RetireMossCarbon();
        toucanImplementation = new RetireToucanCarbon();
        c3Implementation = new RetireC3Carbon();
        masterImplementation = new KlimaRetirementAggregator();

        admin.upgrade(TransparentUpgradeableProxy(payable(masterAddress)), address(masterImplementation));
        admin.upgrade(
            TransparentUpgradeableProxy(payable(wrappedMasterProxy.bridgeHelper(1))),
            address(toucanImplementation)
        );
        admin.upgrade(
            TransparentUpgradeableProxy(payable(wrappedMasterProxy.bridgeHelper(0))),
            address(mossImplementation)
        );
        admin.upgrade(
            TransparentUpgradeableProxy(payable(wrappedMasterProxy.bridgeHelper(2))),
            address(c3Implementation)
        );

        /* ======= Logs ======= */

        console.log("======= Immutable Deployments =======");
        console.log("Proxy admin used:", address(admin));
        console.log("Toucan implementation deployed to:", address(toucanImplementation));
        console.log("Moss implementation deployed to:", address(mossImplementation));
        console.log("C3 implementation deployed to:", address(c3Implementation));
        console.log("======= Proxy Deployments =======");
        console.log("Toucan proxy upgraded:", wrappedMasterProxy.bridgeHelper(1));
        console.log("Moss proxy upgraded:", wrappedMasterProxy.bridgeHelper(0));
        console.log("C3 proxy upgraded:", wrappedMasterProxy.bridgeHelper(2));

        vm.stopBroadcast();
    }
}
