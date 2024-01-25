# onchain

Onchain is a library for working with onchain metadata (especially for NFTs).

## Json.sol

- Craft JSON objects and arrays

## Metadata.sol

- Easily render NFT attributes/traits as correctly formatted JSON objects
- Easily encode data URIs JSON and SVG with arbitrary encoings. Base64 has first-class support.
- Support for OpenSea's mystifying DisplayTypes 

## Svg.sol
A tweaked version of w1nt3r.eth's excellent [SVG.sol](https://github.com/w1nt3r-eth/hot-chain-svg/blob/main/contracts/SVG.sol)

- Create SVGs with support for basic shapes, paths, text, css styles, and arbitrary elements

## Convenience
`src/Solarray.sol` imports [Solarray](https://github.com/evmcheb/Solarray) for easy-access without having to add another root-level dependency or remapping to your project. This makes working with arrays of strings (like attributes or JSON properties) much easier.