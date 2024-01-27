# onchain 🔛⛓️

Onchain is a library for working with onchain metadata (especially for NFTs). It's a re-packaging of the [onchain component of shipyard-core](https://github.com/ProjectOpenSea/shipyard-core/tree/main/src/onchain), which was sort of a repackaging of my original [sol-json library](https://github.com/emo-eth/sol-json) (ashes to ashes, etc).

## Json.sol

- Craft JSON objects and arrays

```solidity
string memory myObject = Json.objectOf(
    Solarray.strings(
        // property encloses the property value in quotes and escapes the value according to JSON spec
        Json.property("name", string.concat("Example NFT #", LibString.toString(tokenId))),
        Json.property("description", "This is an example NFT"),
        Json.property("image", Metadata.base64SvgDataURI(_image(tokenId))),
        Json.property(
            "quote",
            // quote encloses the property value in quotes and escapes the value according to JSON spec
            Json.quote('"This is my famous quote"')
        ),
        Json.rawProperty(
            "numbers",
            // arrayOf does not escape the values in the array, as it assumes they are already escaped
            Json.arrayOf(Solarray.strings(LibString.toString(1), LibString.toString(2), LibString.toString(3)))
        )
    )
  );
```

## Metadata.sol

- Easily render NFT attributes/traits as correctly formatted JSON objects
- Easily encode data URIs JSON and SVG with arbitrary encoings. Base64 has first-class support.
- Support for OpenSea's mystifying DisplayTypes

```solidity
string memory myAttribute = Metadata.attribute("color", "blue"); // {"trait_type": "color", "value": "blue"}
string memory myOtherAttribute = Metadata.attribute("level", LibString.toString(5), DisplayType.Number); // {"trait_type": "level", "value": "5", "display_type": "number"}
string memory mySvgImage = ...
string memory myEncodedSvg = Metadata.base64SvgDataURI(mySvgImage);
string memory myFullTokenURI = ...
string memory myEncodedURI = Metadata.base64JsonDataURI(myFullTokenURI);
```

## Svg.sol
A tweaked version of w1nt3r.eth's excellent [SVG.sol](https://github.com/w1nt3r-eth/hot-chain-svg/blob/main/contracts/SVG.sol)

- Create SVGs with support for basic shapes, paths, text, css styles, and arbitrary elements

```solidity
string memory mySvg = Svg.top({
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
```

## Convenience
- `src/Solarray.sol` imports [Solarray](https://github.com/evmcheb/Solarray) for easy-access without having to add another root-level dependency or remapping to your project. This makes working with arrays of strings (like attributes or JSON properties) much easier.
- `src/LibString` imports [LibString]([https://github.com/vectorized/solady/utils/LibString.sol](https://github.com/Vectorized/solady/blob/main/src/utils/LibString.sol)https://github.com/Vectorized/solady/blob/main/src/utils/LibString.sol) for easy-access without having to add another root-level dependency or remapping to your project.
