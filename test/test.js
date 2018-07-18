const cotization_oracle = artifacts.require('cotization_oracle')
contract('cotization_oracle', addresses => {
  const owner = addresses[0]
  const operator = addresses[1]
  const client = addresses[2]
  let instancecotization_oracle
  beforeEach(async () => {
     instancecotization_oracle = await cotization_oracle.new( {from: owner})
  })

  describe('testing usability', () => {

    it('setCurrencyCotization should work when used by owner', async () => {
      try {
        await instancecotization_oracle.
          setCurrencyCotization( "dollar" , 1, 1, 1 )
        let currency_after = await instancecotization_oracle
          .getCurrencyCotization( "dollar", {from: owner})
        let currency_return = web3.eth.getTransaction(currency_after.receipt.transactionHash)
        console.log(currency_return);
        
       // console.log(JSON.stringify(currency_after))

      }
      catch(error) {
      }
    })
})
})