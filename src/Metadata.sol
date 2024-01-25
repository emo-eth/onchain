// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Json} from "./Json.sol";
import {LibString} from "solady/utils/LibString.sol";
import {Solarray} from "./Solarray.sol";
import {Base64} from "solady/utils/Base64.sol";

///@notice modified from https://github.com/ProjectOpenSea/shipyard-core/blob/main/src/onchain/Metadata.sol

enum DisplayType {
    String,
    Number,
    Date,
    BoostPercent,
    BoostNumber,
    Hidden
}

library Metadata {
    string private constant NULL = "";

    using LibString for string;

    function attribute(string memory traitType, string memory value) internal pure returns (string memory) {
        return Json.objectOf(Solarray.strings(Json.property("trait_type", traitType), Json.property("value", value)));
    }

    function attribute(string memory traitType, string memory value, DisplayType displayType)
        internal
        pure
        returns (string memory)
    {
        return Json.objectOf(
            Solarray.strings(
                Json.property("trait_type", traitType),
                Json.property("value", value),
                Json.property("display_type", toString(displayType))
            )
        );
    }

    function toString(DisplayType displayType) internal pure returns (string memory) {
        if (displayType == DisplayType.String) {
            return "string";
        } else if (displayType == DisplayType.Number) {
            return "number";
        } else if (displayType == DisplayType.Date) {
            return "date";
        } else if (displayType == DisplayType.BoostNumber) {
            return "boost_number";
        } else if (displayType == DisplayType.BoostPercent) {
            return "boost_percent";
        } else {
            return "hidden";
        }
    }

    function dataURI(string memory dataType, string memory encoding, string memory content)
        internal
        pure
        returns (string memory)
    {
        return string.concat(
            "data:", dataType, ";", bytes(encoding).length > 0 ? string.concat(encoding, ",") : NULL, content
        );
    }

    function dataURI(string memory dataType, string memory content) internal pure returns (string memory) {
        return dataURI(dataType, NULL, content);
    }

    function jsonDataURI(string memory content, string memory encoding) internal pure returns (string memory) {
        return dataURI("application/json", encoding, content);
    }

    function jsonDataURI(string memory content) internal pure returns (string memory) {
        return jsonDataURI(content, NULL);
    }

    function base64JsonDataURI(string memory content) internal pure returns (string memory) {
        return jsonDataURI(Base64.encode(bytes(content)), "base64");
    }

    function svgDataURI(string memory content, string memory encoding, bool escape)
        internal
        pure
        returns (string memory)
    {
        string memory uri = dataURI("image/svg+xml", encoding, content);

        if (escape) {
            return uri.escapeJSON();
        } else {
            return uri;
        }
    }

    function svgDataURI(string memory content) internal pure returns (string memory) {
        return svgDataURI(content, "utf8", true);
    }

    function base64SvgDataURI(string memory content) internal pure returns (string memory) {
        return svgDataURI(Base64.encode(bytes(content)), "base64", false);
    }
}
