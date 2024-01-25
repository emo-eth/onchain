// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {LibString} from "solady/utils/LibString.sol";

/**
 * @title JSON
 * @author emo.eth
 * @notice TODO: overrides for common types that automatically stringify
 */
library json {
    string private constant NULL = "";

    using LibString for string;

    /**
     * @notice enclose a string in {braces}
     *         Note: does not escape quotes in value
     * @param  value string to enclose in braces
     * @return string of {value}
     */
    function object(string memory value) internal pure returns (string memory) {
        return string.concat("{", value, "}");
    }

    /**
     * @notice enclose a string in [brackets]
     *         Note: does not escape quotes in value
     * @param value string to enclose in brackets
     * @return string of [value]
     */
    function array(string memory value) internal pure returns (string memory) {
        return string.concat("[", value, "]");
    }

    /**
     * @notice enclose name and value with quotes, and place a colon "between":"them".
     *         Note: escapes quotes in name and value
     * @param name name of property
     * @param value value of property
     * @return string of "name":"value"
     */
    function property(string memory name, string memory value) internal pure returns (string memory) {
        return string.concat('"', name.escapeJSON(), '":"', value.escapeJSON(), '"');
    }

    /**
     * @notice enclose name with quotes, but not rawValue, and place a colon "between":them
     *         Note: escapes quotes in name, but not value (which may itself be a JSON object, array, etc)
     * @param name name of property
     * @param rawValue raw value of property, which will not be enclosed in quotes
     * @return string of "name":value
     */
    function rawProperty(string memory name, string memory rawValue) internal pure returns (string memory) {
        return string.concat('"', name.escapeJSON(), '":', rawValue);
    }

    /**
     * @notice comma-join an array of properties and {"enclose":"them","in":"braces"}
     *         Note: does not escape quotes in properties, as it assumes they are already escaped
     * @param properties array of '"name":"value"' properties to join
     * @return string of {"name":"value","name":"value",...}
     */
    function objectOf(string[] memory properties) internal pure returns (string memory) {
        return object(_commaJoin(properties));
    }

    /**
     * @notice comma-join an array of values and enclose them [in,brackets]
     *         Note: does not escape quotes in values, as it assumes they are already escaped
     * @param values array of values to join
     * @return string of [value,value,...]
     */
    function arrayOf(string[] memory values) internal pure returns (string memory) {
        return array(_commaJoin(values));
    }

    /**
     * @notice comma-join two arrays of values and [enclose,them,in,brackets]
     *         Note: does not escape quotes in values, as it assumes they are already escaped
     * @param values1 first array of values to join
     * @param values2 second array of values to join
     * @return string of [values1_0,values1_1,values2_0,values2_1...]
     */
    function arrayOf(string[] memory values1, string[] memory values2) internal pure returns (string memory) {
        if (values1.length == 0) {
            return arrayOf(values2);
        } else if (values2.length == 0) {
            return arrayOf(values1);
        }
        return array(string.concat(_commaJoin(values1), ",", _commaJoin(values2)));
    }

    /**
     * @notice enclose a string in double "quotes", escaping any existing quotes
     * @param str string to enclose in quotes
     * @return string of "value"
     */
    function quote(string memory str) internal pure returns (string memory) {
        return string.concat('"', str.escapeJSON(), '"');
    }

    /**
     * @notice enclose each string in an array in double "quotes", escaping any existing quotes
     * @param strs array of strings, each to escape and enclose in quotes
     */
    function quote(string[] memory strs) internal pure returns (string[] memory) {
        string[] memory result = new string[](strs.length);
        for (uint256 i = 0; i < strs.length;) {
            result[i] = quote(strs[i]);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    /**
     * @notice comma-join an array of strings
     * @param values array of strings to join
     * @return string of value,value,...
     */
    function _commaJoin(string[] memory values) internal pure returns (string memory) {
        return _join(values, ",");
    }

    /**
     * @notice join two strings with a comma
     * @param value1 first string
     * @param value2 second string
     * @return string of value1,value2
     */
    function _commaJoin(string memory value1, string memory value2) internal pure returns (string memory) {
        return string.concat(value1, ",", value2);
    }

    /**
     * @notice join an array of strings with a specified separator
     * @param values array of strings to join
     * @param separator separator to join with
     * @return string of value<separator>value<separator>...
     */
    function _join(string[] memory values, string memory separator) internal pure returns (string memory) {
        if (values.length == 0) {
            return NULL;
        }
        string memory result = values[0];
        for (uint256 i = 1; i < values.length; ++i) {
            result = string.concat(result, separator, values[i]);
        }
        return result;
    }
}
