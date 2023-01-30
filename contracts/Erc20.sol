// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//ERC Token Starndard #20 Interface
interface ERC20 {
function transfer(address recipient, uint256 _value) external returns (bool);
function approve(address _spender, uint256 _value) external returns (bool);
function transferFrom(address sender, address recipient, uint256 _value) external returns (bool);
function totalSupply() external view returns (uint256);
function balanceOf(address _owner) external view returns (uint256);
function allowance(address _owner, address _spender) external view returns (uint256);
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract AmykyToken is ERC20 {
string public constant name = "AmykyToken";
string public constant symbol = "AT";
uint8 public constant decimals = 18;
uint256 public totalSupply;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowed;


constructor() {
    totalSupply = 1_000_000_000_000;
    balances[0x98Ab2897CFbC0EA52d1C1cf0805f43151B160658] = totalSupply;
    emit Transfer(address(0),0x98Ab2897CFbC0EA52d1C1cf0805f43151B160658, totalSupply);
    }



function transfer(address _to, uint256 _value) external returns (bool) {
    require(balances[msg.sender] >= _value, "Insufficient balance.");
    require(_value > 0, "Value must be greater than 0.");
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
}

function approve(address _spender, uint256 _value) external returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
}

function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
    require(balances[_from] >= _value, "Insufficient balance.");
    require(allowed[_from][msg.sender] >= _value, "Allowance is not enough.");
    require(_value > 0, "Value must be greater than 0.");
    balances[_from] -= _value;
    allowed[_from][msg.sender] -= _value;
    balances[_to] += _value;
    emit Transfer(_from, _to, _value);
    return true;
}


function balanceOf(address _owner) external view returns (uint256) {
    return balances[_owner];
}

function allowance(address _owner, address _spender) external view returns (uint256) {
    return allowed[_owner][_spender];
}

}


