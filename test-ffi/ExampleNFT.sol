// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Json} from "../src/Json.sol";
import {Svg} from "../src/Svg.sol";
import {LibString} from "solady/utils/LibString.sol";
import {Solarray} from "../src/Solarray.sol";
import {Metadata, DisplayType} from "../src/Metadata.sol";
import {ERC721} from "solady/tokens/ERC721.sol";

contract ExampleNFT is ERC721 {
    uint256 currentId;

    function name() public pure override returns (string memory) {
        return "ExampleNFT";
    }
    /**
     * @notice Get the metdata URI for a given token ID
     * @param tokenId The token ID to get the tokenURI for
     */

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return _stringURI(tokenId);
    }

    function symbol() public pure override returns (string memory) {
        return "EXNFT";
    }

    /**
     * @notice Helper function to get the raw JSON metadata representing a given token ID
     * @param tokenId The token ID to get URI for
     */
    function _stringURI(uint256 tokenId) internal view returns (string memory) {
        return Json.objectOf(
            Solarray.strings(
                Json.property("name", string.concat("Example NFT #", LibString.toString(tokenId))),
                Json.property("description", "This is an example NFT"),
                Json.property("image", Metadata.base64SvgDataURI(_image(tokenId))),
                Json.rawProperty("attributes", Json.arrayOf(_staticAttributes(tokenId)))
            )
        );
    }

    /**
     * @notice Helper function to get the static attributes for a given token ID
     * @param tokenId The token ID to get the static attributes for
     */
    function _staticAttributes(uint256 tokenId) internal view virtual returns (string[] memory) {
        return Solarray.strings(
            Metadata.attribute({traitType: "Example Attribute", value: "Example Value"}),
            Metadata.attribute({
                traitType: "Number",
                value: LibString.toString(tokenId),
                displayType: DisplayType.Number
            }),
            Metadata.attribute({traitType: "Parity", value: tokenId % 2 == 0 ? "Even" : "Odd"})
        );
    }

    /**
     * @notice Helper function to get the raw SVG image for a given token ID
     * @param tokenId The token ID to get the dynamic attributes for
     */
    function _image(uint256 tokenId) internal pure virtual returns (string memory) {
        return Svg.top({
            props: string.concat(Svg.prop("width", "500"), Svg.prop("height", "500")),
            children: string.concat(
                Svg.rect({
                    props: string.concat(Svg.prop("width", "500"), Svg.prop("height", "500"), Svg.prop("fill", "lightgray"))
                }),
                Svg.text({
                    props: string.concat(
                        Svg.prop("x", "50%"),
                        Svg.prop("y", "50%"),
                        Svg.prop("dominant-baseline", "middle"),
                        Svg.prop("text-anchor", "middle"),
                        Svg.prop("font-size", "48"),
                        Svg.prop("fill", "black")
                        ),
                    children: LibString.toString(tokenId)
                })
                )
        });
    }

    function mint(address to) public {
        unchecked {
            _mint(to, ++currentId);
        }
    }
}
