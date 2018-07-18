pragma solidity ^0.4.23;

contract cotization_oracle { 

  address owner;
  address operator;
  bool operatorInstantiated = false;
  uint fee;
  
  struct currencyCotization {
    uint last_updated;
    string value_avg;
    string value_sell;
    string value_buy;
  }
  
  mapping (string=>currencyCotization) currencyMap;

  modifier onlyOwnerOrOperator() {
    require(msg.sender == owner || (msg.sender == operator && operatorInstantiated == true));
    _;
  }

  modifier onlyOwner() {
    require(msg.sender == owner );
    _;
  }
  event CallbackGetCotization(string currency);

  constructor() public {
    owner = msg.sender;
    fee = 0;
  }

  function updateCotization(string _currency ) public onlyOwnerOrOperator {
    emit CallbackGetCotization( _currency );
  }

  function setCurrencyCotization( string _currency, string _value_avg, string _value_sell, 
  string _value_buy )
  public onlyOwnerOrOperator{
    currencyMap[_currency].last_updated = now;
    currencyMap[_currency].value_avg = _value_avg;
    currencyMap[_currency].value_sell = _value_sell;
    currencyMap[_currency].value_buy = _value_buy;
  }


  function getCurrencyCotization(string _currency) public payable returns
  (uint last_updated, string value_avg,  string value_sell,  string value_buy) {
    require( (msg.value >= fee) || ((msg.sender == owner) && (msg.value == 0) ));
    if(msg.sender != owner){
      uint change = msg.value - fee ; 
      owner.transfer(fee);
      msg.sender.transfer(change);
    }
    currencyCotization memory c = currencyMap[_currency];
    return  (c.last_updated, c.value_avg, c.value_sell, c.value_buy );
  }

  function updateFee (uint value) public onlyOwnerOrOperator {
    fee = value;
  }

  event initializeOperatorEvent(address operator);
  function initializeOperator(address _operator ) public onlyOwner {
    operator = _operator;
    operatorInstantiated = true;
    emit initializeOperatorEvent(operator);
  }
}
