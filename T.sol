// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./utils/cryptography/ECDSA.sol";
import "./utils/Strings.sol";

import "./IHEVM.sol";

contract T {
    using ECDSA for bytes32;

    IHEVM HEVM = IHEVM(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    address constant ADDR1 = address(0x5409ED021D9299bf6814279A6A1411A7e866A631);
    uint256 constant SK1 = 0xf2f48ee19680706196e2e339e5da3491186e0c4c5030670656b0e0164837257d;

    address constant ADDR2 = address(0x6Ecbe1DB9EF729CBe972C83Fb886247691Fb6beb);
    uint256 constant SK2 = 0x5d862464fe9303452126c8bc94274b8c5f9874cbd219789b3eb2128075a76f72;

    bytes32 constant HASH = 0xd36559b60daeb61527567d584bdb80b3226b4a6ab152452abbba4315256da519;
    event AssertionFailed(string message);

    function t(address addr, uint256 sk, bytes32 hash) internal {
        (uint8 v, bytes32 r, bytes32 s) = HEVM.sign(sk, hash);

        bytes memory p_sig = abi.encodePacked(r, s, v);
        (address ra, ) = hash.tryRecover(p_sig);

        assert(ra == addr);

        string memory str = string(abi.encodePacked("sk = ", Strings.toHexString(sk),
                                                    ", hash = ", Strings.toHexString(uint256(hash)),
                                                    ", v = ", Strings.toHexString(v),
                                                    ", r = ", Strings.toHexString(uint256(r)),
                                                    ", s = ", Strings.toHexString(uint256(s))));
        //emit AssertionFailed(str);
    }

    function t1() public {
        t(ADDR1, SK1, HASH);
    }

    function t2() public {
        t(ADDR2, SK2, HASH);
    }

    function t3() public {
        t(ADDR1, SK1, 0x3ac225168df54212a25c1c01fd35bebfea408fdac2e31ddd6f80a4bbf9a5f1cb);
    }
}
