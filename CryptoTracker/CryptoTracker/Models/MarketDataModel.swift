//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 24/12/2023.
//

import Foundation



struct GlopalData: Codable {
    let data: MarketDataModel?
}


struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey  {
    case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
        if let item = totalMarketCap.first(where: { key , value in
            return key == "usd"
        }) {
            return "$" + "\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var volume : String {
        if let item = totalVolume.first(where: { key , value in
            key == "usd"
        }) {
            return "\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    // here we but 'btc' cause it's a coin name not else
    var precenyage: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc" }) {
            return "\(item.value.asPrecentString())"
        }
        return ""
    }
    
}

// Json data
/*
https://api.coingecko.com/api/v3/global

 json response
 
 {
   "data": {
     "active_cryptocurrencies": 11715,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 956,
     "total_market_cap": {
       "btc": 40146606.4458637,
       "eth": 765093988.4214374,
       "ltc": 24249593186.67598,
       "bch": 7593652589.707137,
       "bnb": 6509340979.056955,
       "eos": 2114481872784.5464,
       "xrp": 2831858462607.4126,
       "xlm": 13754934770502.78,
       "link": 111654563687.2432,
       "dot": 193034097232.47385,
       "yfi": 207489617.0349173,
       "usd": 1755468587677.699,
       "aed": 6447133935105.134,
       "ars": 1412045111016513.8,
       "aud": 2580812676985.897,
       "bdt": 192635913623539.75,
       "bhd": 661753727091.0978,
       "bmd": 1755468587677.699,
       "brl": 8529997414384.702,
       "cad": 2334334354464.424,
       "chf": 1505280960030.4614,
       "clp": 1536311605848662.5,
       "cny": 12521406342187.492,
       "czk": 39193996063362.46,
       "dkk": 11884083471431.12,
       "eur": 1592622544141.7793,
       "gbp": 1384931300065.0415,
       "gel": 4722210500853.014,
       "hkd": 13709858576045.322,
       "huf": 607207807134779.9,
       "idr": 27151569325322830,
       "ils": 6350886858848.5205,
       "inr": 146290658152680.2,
       "jpy": 249996281571181.12,
       "krw": 2280406359450962,
       "kwd": 538858637673.5484,
       "lkr": 571333200291827.4,
       "mmk": 3685889720232811,
       "mxn": 29799079275828.98,
       "myr": 8172584009933.529,
       "ngn": 1445952732861657,
       "nok": 17889453736447.152,
       "nzd": 2788228312494.3687,
       "php": 97138868342894.12,
       "pkr": 489698086320041.06,
       "pln": 6908372773705.904,
       "rub": 161719848995526.06,
       "sar": 6584811825499.5,
       "sek": 17568729625478.428,
       "sgd": 2325995878672.953,
       "thb": 60785139702839.164,
       "try": 51066581215544.305,
       "twd": 54532227301337.72,
       "uah": 65799621679791.78,
       "vef": 175775069684.16824,
       "vnd": 42571578237118350,
       "zar": 32484489793143.04,
       "xdr": 1309339067211.0513,
       "xag": 72555026431.70471,
       "xau": 855071194.371931,
       "bits": 40146606445863.7,
       "sats": 4014660644586370
     },
     "total_volume": {
       "btc": 1589962.1294499643,
       "eth": 30300704.71087719,
       "ltc": 960378428.8311895,
       "bch": 300738246.90798837,
       "bnb": 257795279.86589336,
       "eos": 83741725609.34467,
       "xrp": 112152635306.292,
       "xlm": 544749041432.54675,
       "link": 4421956014.697387,
       "dot": 7644902806.568777,
       "yfi": 8217397.74654314,
       "usd": 69523399882.13687,
       "aed": 255331638407.13647,
       "ars": 55922491347274,
       "aud": 102210243477.12288,
       "bdt": 7629133183309.919,
       "bhd": 26208027483.369434,
       "bmd": 69523399882.13687,
       "brl": 337821152367.291,
       "cad": 92448740993.27164,
       "chf": 59614994454.33462,
       "clp": 60843929003755.24,
       "cny": 495896506679.30585,
       "czk": 1552235044488.494,
       "dkk": 470656036352.09674,
       "eur": 63074061692.07052,
       "gbp": 54848678728.61497,
       "gel": 187017945682.9483,
       "hkd": 542963848399.5136,
       "huf": 24047796402231.82,
       "idr": 1075307997467029.1,
       "ils": 251519878961.79828,
       "inr": 5793680386627.96,
       "jpy": 9900827377215.111,
       "krw": 90312982148892.28,
       "kwd": 21340902827.82081,
       "lkr": 22627022111729.418,
       "mmk": 145975602605457.38,
       "mxn": 1180159712999.275,
       "myr": 323666188151.28827,
       "ngn": 57265365363442.375,
       "nok": 708492111178.8932,
       "nzd": 110424711266.79689,
       "php": 3847077888665.2407,
       "pkr": 19393953338569.27,
       "pln": 273598494585.76794,
       "rub": 6404736495723.045,
       "sar": 260784219613.09192,
       "sek": 695790186020.4264,
       "sgd": 92118504843.83142,
       "thb": 2407328507109.6504,
       "try": 2022435702571.3633,
       "twd": 2159688798618.6816,
       "uah": 2605921542685.774,
       "vef": 6961378030.198374,
       "vnd": 1686000466296155.8,
       "zar": 1286512438734.9739,
       "xdr": 51854931606.29024,
       "xag": 2873461907.2526155,
       "xau": 33864152.84859007,
       "bits": 1589962129449.9644,
       "sats": 158996212944996.44
     },
     "market_cap_percentage": {
       "btc": 48.769989214186396,
       "eth": 15.720690288781555,
       "usdt": 5.206307874238434,
       "sol": 2.739317655134798,
       "bnb": 2.363746702623767,
       "xrp": 1.9103103165016053,
       "usdc": 1.4283536357052444,
       "ada": 1.2327329261663844,
       "steth": 1.1879782454495824,
       "avax": 0.9931115405486737
     },
     "market_cap_change_percentage_24h_usd": 0.9908811635642969,
     "updated_at": 1703425238
   }
 }


*/
