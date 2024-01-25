// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import {Svg} from "../src/Svg.sol";

contract svgTest is Test {
    function testTop() public {
        string memory expected =
            '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"><circle width="100" height="100"/></svg>';
        string memory actual = Svg.top('width="100" height="100"', '<circle width="100" height="100"/>');

        assertEq(expected, actual);

        expected = '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"></svg>';
        actual = Svg.top('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = '<svg xmlns="http://www.w3.org/2000/svg" ></svg>';
        actual = Svg.top("", "");

        assertEq(expected, actual);
    }

    function testSvg() public {
        string memory expected =
            '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"><circle width="100" height="100"/></svg>';
        string memory actual = Svg.svg('width="100" height="100"', '<circle width="100" height="100"/>', true);

        assertEq(expected, actual);

        expected = '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"></svg>';
        actual = Svg.svg('width="100" height="100"', "", true);

        assertEq(expected, actual);

        expected = '<svg width="100" height="100"></svg>';
        actual = Svg.svg('width="100" height="100"', "", false);

        assertEq(expected, actual);

        expected = "<svg ></svg>";
        actual = Svg.svg("", "", false);

        assertEq(expected, actual);
    }

    function testG() public {
        string memory expected = '<g width="100" height="100"><circle width="100" height="100"></circle></g>';
        string memory actual = Svg.g('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<g width="100" height="100"></g>';
        actual = Svg.g('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<g ></g>";
        actual = Svg.g("", "");

        assertEq(expected, actual);
    }

    function testPath() public {
        string memory expected = '<path width="100" height="100"><circle width="100" height="100"></circle></path>';
        string memory actual = Svg.path('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<path width="100" height="100"></path>';
        actual = Svg.path('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<path ></path>";
        actual = Svg.path("", "");

        assertEq(expected, actual);
    }

    function testText() public {
        string memory expected = '<text width="100" height="100"><circle width="100" height="100"></circle></text>';
        string memory actual = Svg.text('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<text width="100" height="100"></text>';
        actual = Svg.text('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<text ></text>";
        actual = Svg.text("", "");

        assertEq(expected, actual);
    }

    function testLine() public {
        string memory expected = '<line width="100" height="100"><circle width="100" height="100"></circle></line>';
        string memory actual = Svg.line('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<line width="100" height="100"></line>';
        actual = Svg.line('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<line ></line>";
        actual = Svg.line("", "");

        assertEq(expected, actual);
    }

    function testCircle() public {
        string memory expected = '<circle width="100" height="100"><circle width="100" height="100"></circle></circle>';
        string memory actual = Svg.circle('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<circle width="100" height="100"></circle>';
        actual = Svg.circle('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<circle ></circle>";
        actual = Svg.circle("", "");
    }

    function testCircleNoChildren() public {
        string memory expected = '<circle width="100" height="100"/>';
        string memory actual = Svg.circle('width="100" height="100"');

        assertEq(expected, actual);

        expected = "<circle />";
        actual = Svg.circle("");

        assertEq(expected, actual);
    }

    function testRect() public {
        string memory expected = '<rect width="100" height="100"><circle width="100" height="100"></circle></rect>';
        string memory actual = Svg.rect('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<rect width="100" height="100"></rect>';
        actual = Svg.rect('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<rect ></rect>";
        actual = Svg.rect("", "");

        assertEq(expected, actual);
    }

    function testRectNoChildren() public {
        string memory expected = '<rect width="100" height="100"/>';
        string memory actual = Svg.rect('width="100" height="100"');

        assertEq(expected, actual);

        expected = "<rect />";
        actual = Svg.rect("");

        assertEq(expected, actual);
    }

    function testFilter() public {
        string memory expected = '<filter width="100" height="100"><circle width="100" height="100"></circle></filter>';
        string memory actual = Svg.filter('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<filter width="100" height="100"></filter>';
        actual = Svg.filter('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<filter ></filter>";
        actual = Svg.filter("", "");
    }

    function testCdata() public {
        string memory expected = "<![CDATA[<svg></svg>]]>";
        string memory actual = Svg.cdata("<svg></svg>");

        assertEq(expected, actual);
    }

    function testRadialGradient() public {
        string memory expected =
            '<radialGradient width="100" height="100"><circle width="100" height="100"></circle></radialGradient>';
        string memory actual =
            Svg.radialGradient('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<radialGradient width="100" height="100"></radialGradient>';
        actual = Svg.radialGradient('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<radialGradient ></radialGradient>";
        actual = Svg.radialGradient("", "");
    }

    function testLinearGradient() public {
        string memory expected =
            '<linearGradient width="100" height="100"><circle width="100" height="100"></circle></linearGradient>';
        string memory actual =
            Svg.linearGradient('width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<linearGradient width="100" height="100"></linearGradient>';
        actual = Svg.linearGradient('width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<linearGradient ></linearGradient>";
        actual = Svg.linearGradient("", "");
    }

    function testGradientStop() public {
        string memory expected = '<stop stop-color="red" offset="0%" width="100" height="100"/>';
        string memory actual = Svg.gradientStop(0, "red", 'width="100" height="100"');

        assertEq(expected, actual);

        expected = '<stop stop-color="red" offset="0%" />';
        actual = Svg.gradientStop(0, "red", "");

        assertEq(expected, actual);
    }

    function testAnimateTransform() public {
        string memory expected = '<animateTransform width="100" height="100"/>';
        string memory actual = Svg.animateTransform('width="100" height="100"');

        assertEq(expected, actual);

        expected = "<animateTransform />";
        actual = Svg.animateTransform("");

        assertEq(expected, actual);
    }

    function testImage() public {
        string memory expected = '<image href="https://example.com" width="100" height="100"/>';
        string memory actual = Svg.image("https://example.com", 'width="100" height="100"');

        assertEq(expected, actual);

        expected = '<image href="https://example.com" />';
        actual = Svg.image("https://example.com", "");

        assertEq(expected, actual);
    }

    function testEl() public {
        string memory expected = '<rect width="100" height="100"><circle width="100" height="100"></circle></rect>';
        string memory actual = Svg.el("rect", 'width="100" height="100"', '<circle width="100" height="100"></circle>');

        assertEq(expected, actual);

        expected = '<rect width="100" height="100"></rect>';
        actual = Svg.el("rect", 'width="100" height="100"', "");

        assertEq(expected, actual);

        expected = "<rect ></rect>";
        actual = Svg.el("rect", "", "");

        assertEq(expected, actual);
    }

    function testElNoChildren() public {
        string memory expected = '<rect width="100" height="100"/>';
        string memory actual = Svg.el("rect", 'width="100" height="100"');

        assertEq(expected, actual);

        expected = "<rect />";
        actual = Svg.el("rect", "");

        assertEq(expected, actual);
    }

    function testProp() public {
        string memory expected = 'width="100" ';
        string memory actual = Svg.prop("width", "100");

        assertEq(expected, actual);
    }

    function testSetCssVar() public {
        string memory expected = "--width:100;";
        string memory actual = Svg.setCssVar("width", "100");

        assertEq(expected, actual);
    }

    function testGetCssVar() public {
        string memory expected = "var(--width)";
        string memory actual = Svg.getCssVar("width");

        assertEq(expected, actual);
    }

    function testGetDefURL() public {
        string memory expected = "url(#id)";
        string memory actual = Svg.getDefURL("id");

        assertEq(expected, actual);
    }

    function testRgba() public {
        string memory expected = "rgba(100,100,100,0.1)";
        string memory actual = Svg.rgba(100, 100, 100, 1);

        assertEq(expected, actual);

        expected = "rgba(100,100,100,1)";
        actual = Svg.rgba(100, 100, 100, 100);

        assertEq(expected, actual);
    }
}
