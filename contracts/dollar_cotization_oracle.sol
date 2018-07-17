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
  }

  function updateCotization(string _currency ) public onlyOwnerOrOperator {
    emit CallbackGetCotization( _currency );
  }

  function setCurrencyCotization( string _currency, string _value_avg, string _value_sell, string _value_buy )
  public onlyOwnerOrOperator{
    currencyMap[currency].timestamp = now;
    currencyMap[currency].value_avg = _value_avg;
    currencyMap[currency].value_sell = _value_sell;
    currencyMap[currency].value_buy = _value_buy;
  }

  function getCurrencyCotization() constant public payable
  returns (uint timestamp, string value_avg,  string value_sell,  string value_buy) {
    require(msg.value >= fee);
    return  (currencyMap[currency].timestamp, currencyMap[currency].value_avg, currencyMap[currency].value_sell, currencyMap[currency].value_buy);
  }

  function updateFee (uint value) onlyOwnerOrOperator {
    fee = value;
  }

  event initializeOperatorEvent(address operator);
  function initializeOperator(address _operator ) public onlyOwner {
    operator = _operator;
    operatorInstantiated = true;
    emit initializeOperatorEvent(operator);
  }
}
