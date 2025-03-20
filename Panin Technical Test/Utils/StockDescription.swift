//
//  StockDescription.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 18/03/25.
//

enum StockDescription: String {
    case ADRO
    case ASII
    case BBCA
    case BBNI
    case BBRI
    case BMRI
    case CTRA
    case GGRM
    
    var value: String {
        switch self {
            case .ADRO: return "Adaro Energy Indonesia Tbk."
            case .ASII: return "Astra International Tbk."
            case .BBCA: return "Bank Central Asia Tbk."
            case .BBNI: return "Bank Negara Indonesia Tbk."
            case .BBRI: return "Bank Rakyat Indonesia Tbk."
            case .BMRI: return "Bank Mandiri Tbk."
            case .CTRA: return "Ciputra Development Tbk."
            case .GGRM: return "Gudang Garam Tbk."
        }
    }
}

