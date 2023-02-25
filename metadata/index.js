const express = require('express')
const path = require('path')
const moment = require('moment')
const { HOST } = require('./src/constants')
const db = require('./src/database')

const PORT = process.env.PORT || 5001

const app = express()
  .set('port', PORT)
  .set('views', path.join(__dirname, 'views'))
  .set('view engine', 'ejs')

// Static public files
app.use(express.static(path.join(__dirname, 'public')))

app.get('/', function(req, res) {
  res.send('Get ready for OpenSea!');
})

app.get('/api/token/:token_id', function(req, res) {
  const tokenId = parseInt(req.params.token_id).toString()
  const nft = db[tokenId]
  const { level, age } = nft

  const data = {
    'name': 'Broasted Chicken House NFT',
    'description': 'NFT is for Broasted chicken house restaurant, Ampang, KL',
    'external_url': 'https://broastedchickenhouse.com',
    'details': {
      'owner_verified': 0, //0 = mobile number not verified, 1 = mobile number verified
    },
    'attributes': {
      'lineage level': lineage(level),
      'discount': "25%",
      'age': getAge(age),
    },
    'image': `${HOST}/images/chicken.jpeg`
  }
  res.send(data)
})

app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
})

    //age == 1 // nesting period // 7 days
    //age == 2 // egg // 7 days
    //age == 3 // baby chick // 7 days
    //age == 4 // half grown chick // 10 days
    //age == 5 // full chicken
function getAge(age) {
  if(age == 1) return "Nesting period";
  if(age == 2) return "Egg";
  if(age == 3) return "Baby chick";
  if(age == 4) return "half grown chicken";
  if(age == 5) return "full chicken";
}

function lineage(level) {
  if(level == 1) return "Level 1";
  if(level == 2) return "Level 2";
}