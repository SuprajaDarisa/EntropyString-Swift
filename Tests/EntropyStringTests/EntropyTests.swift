//
//  EntropyTests.swift
//  EntropyString
//
//  Created by Paul Rogers on 8/14/17.
//  Copyright © 2017 Knoxen. All rights reserved.
//

import XCTest
@testable import EntropyString

class EntropyTests: XCTestCase {
  var random: Entropy!
  let charsets = [.charset64, .charset32, .charset16, .charset8,  .charset4,  .charset2] as [CharSet]

  func testInit() {
    let random = Entropy()
    XCTAssertEqual(random.charset.chars, CharSet.charset32.chars)
  }
  
  // Test bits calculation
  func testZeroEntropy() {
    entropyBits_r0(0, 0, 0)
  }
  
  func testBitsIntInt() {
    entropyBits_r2(    10,   1000, 15.46)
    entropyBits_r2(    10,  10000, 18.78)
    entropyBits_r2(    10, 100000, 22.10)
    
    entropyBits_r2(   100,   1000, 22.24)
    entropyBits_r2(   100,  10000, 25.56)
    entropyBits_r2(   100, 100000, 28.88)
    
    entropyBits_r2(  1000,   1000, 28.90)
    entropyBits_r2(  1000,  10000, 32.22)
    entropyBits_r2(  1000, 100000, 35.54)
    
    entropyBits_r2( 10000,   1000, 35.54)
    entropyBits_r2( 10000,  10000, 38.86)
    entropyBits_r2( 10000, 100000, 42.18)
    
    entropyBits_r2(100000,   1000, 42.19)
    entropyBits_r2(100000,  10000, 45.51)
    entropyBits_r2(100000, 100000, 48.83)
  }
  
  func testBitsIntFloat() {
    entropyBits_r2(    10, 1.0e03, 15.46)
    entropyBits_r2(    10, 1.0e04, 18.78)
    entropyBits_r2(    10, 1.0e05, 22.10)
    
    entropyBits_r2(   100, 1.0e03, 22.24)
    entropyBits_r2(   100, 1.0e04, 25.56)
    entropyBits_r2(   100, 1.0e05, 28.88)
    
    entropyBits_r2(  1000, 1.0e03, 28.90)
    entropyBits_r2(  1000, 1.0e04, 32.22)
    entropyBits_r2(  1000, 1.0e05, 35.54)
    
    entropyBits_r2( 10000, 1.0e03, 35.54)
    entropyBits_r2( 10000, 1.0e04, 38.86)
    entropyBits_r2( 10000, 1.0e05, 42.18)
    
    entropyBits_r2(100000, 1.0e03, 42.19)
    entropyBits_r2(100000, 1.0e04, 45.51)
    entropyBits_r2(100000, 1.0e05, 48.83)
  }
  
  func testBitsFloatFloat() {
    entropyBits_r2(1.0e01, 1.0e03, 15.46)
    entropyBits_r2(1.0e01, 1.0e04, 18.78)
    entropyBits_r2(1.0e01, 1.0e05, 22.10)
    
    entropyBits_r2(1.0e02, 1.0e03, 22.24)
    entropyBits_r2(1.0e02, 1.0e04, 25.56)
    entropyBits_r2(1.0e02, 1.0e05, 28.88)
    
    entropyBits_r2(1.0e03, 1.0e03, 28.90)
    entropyBits_r2(1.0e03, 1.0e04, 32.22)
    entropyBits_r2(1.0e03, 1.0e05, 35.54)
    
    entropyBits_r2(1.0e04, 1.0e03, 35.54)
    entropyBits_r2(1.0e04, 1.0e04, 38.86)
    entropyBits_r2(1.0e04, 1.0e05, 42.18)
    
    entropyBits_r2(1.0e05, 1.0e03, 42.19)
    entropyBits_r2(1.0e05, 1.0e04, 45.51)
    entropyBits_r2(1.0e05, 1.0e05, 48.83)
  }
  
  // From table at http://preshing.com/20110504/hash-collision-probabilities/
  func testPreshing32Bit() {
    // 32-bit column
    entropyBits_r0(30084, 1.0e01, 32)
    entropyBits_r0( 9292, 1.0e02, 32)
    entropyBits_r0( 2932, 1.0e03, 32)
    entropyBits_r0(  927, 1.0e04, 32)
    entropyBits_r0(  294, 1.0e05, 32)
    entropyBits_r0(   93, 1.0e06, 32)
    entropyBits_r0(   30, 1.0e07, 32)
    entropyBits_r0(   10, 1.0e08, 32)
  }
  
  func testPreshing64Bit() {
    // 64-bit column
    entropyBits_r0( 1.97e09, 1.0e01, 64)
    entropyBits_r0( 6.09e08, 1.0e02, 64)
    entropyBits_r0( 1.92e08, 1.0e03, 64)
    entropyBits_r0( 6.07e07, 1.0e04, 64)
    entropyBits_r0( 1.92e07, 1.0e05, 64)
    entropyBits_r0( 6.07e06, 1.0e06, 64)
    entropyBits_r0( 1.92e06, 1.0e07, 64)
    entropyBits_r0(  607401, 1.0e08, 64)
    entropyBits_r0(  192077, 1.0e09, 64)
    entropyBits_r0(   60704, 1.0e10, 64)
    entropyBits_r0(   19208, 1.0e11, 64)
    entropyBits_r0(    6074, 1.0e12, 64)
    entropyBits_r0(    1921, 1.0e13, 64)
    entropyBits_r0(     608, 1.0e14, 64)
    entropyBits_r0(     193, 1.0e15, 64)
    entropyBits_r0(      61, 1.0e16, 64)
    entropyBits_r0(      20, 1.0e17, 64)
    entropyBits_r0(       7, 1.0e18, 64)
  }
  
  func testPreshing160Bit() {
    // 160-bit column
    entropyBits_r0(1.42e24,      2, 160)
    entropyBits_r0(5.55e23,     10, 160)
    entropyBits_r0(1.71e23,    100, 160)
    entropyBits_r0(5.41e22,   1000, 160)
    entropyBits_r0(1.71e22, 1.0e04, 160)
    entropyBits_r0(5.41e21, 1.0e05, 160)
    entropyBits_r0(1.71e21, 1.0e06, 160)
    entropyBits_r0(5.41e20, 1.0e07, 160)
    entropyBits_r0(1.71e20, 1.0e08, 160)
    entropyBits_r0(5.41e19, 1.0e09, 160)
    entropyBits_r0(1.71e19, 1.0e10, 160)
    entropyBits_r0(5.41e18, 1.0e11, 160)
    entropyBits_r0(1.71e18, 1.0e12, 160)
    entropyBits_r0(5.41e17, 1.0e13, 160)
    entropyBits_r0(1.71e17, 1.0e14, 160)
    entropyBits_r0(5.41e16, 1.0e15, 160)
    entropyBits_r0(1.71e16, 1.0e16, 160)
    entropyBits_r0(5.41e15, 1.0e17, 160)
    entropyBits_r0(1.71e15, 1.0e18, 160)
  }
  
  func entropyBits_r0(_ numStrings: Float, _ risk: Float, _ expected: Float) {
    let bits = Entropy.bits(for: numStrings, risk: risk)
    XCTAssertEqual(roundf(bits), expected)
  }
  
  func entropyBits_r2(_ numStrings: Float, _ risk: Float, _ expected: Float) {
    let bits = Entropy.bits(for: numStrings, risk: risk)
    XCTAssertEqual(roundf(bits * 100)/100, expected)
  }


  // Test various ID generation
  func testSmallID() {
    random = Entropy()
    XCTAssertEqual( 6, random.smallID().count)
    XCTAssertEqual( 5, random.smallID(.charset64).count)
    XCTAssertEqual( 6, random.smallID(.charset32).count)
    XCTAssertEqual( 8, random.smallID(.charset16).count)
    XCTAssertEqual(10, random.smallID(.charset8).count)
    XCTAssertEqual(15, random.smallID(.charset4).count)
    XCTAssertEqual(29, random.smallID(.charset2).count)
    
    for charset in charsets {
      let smallIDBits = Float(29)
      let random = Entropy(charset)
      let id = random.smallID()
      let count = Int(ceilf(smallIDBits / Float(charset.bitsPerChar)))
      XCTAssertEqual(id.count, count)
    }
  }
  
  func testMediumID() {
    random = Entropy()
    XCTAssertEqual(14, random.mediumID().count)
    XCTAssertEqual(12, random.mediumID(.charset64).count)
    XCTAssertEqual(14, random.mediumID(.charset32).count)
    XCTAssertEqual(18, random.mediumID(.charset16).count)
    XCTAssertEqual(23, random.mediumID(.charset8).count)
    XCTAssertEqual(35, random.mediumID(.charset4).count)
    XCTAssertEqual(69, random.mediumID(.charset2).count)
    
    for charset in charsets {
      let mediumIDBits = Float(69)
      let random = Entropy(charset)
      let id = random.mediumID()
      let count = Int(ceilf(mediumIDBits / Float(charset.bitsPerChar)))
      XCTAssertEqual(id.count, count)
    }
  }
  
  func testLargeID() {
    random = Entropy()
    XCTAssertEqual(20, random.largeID().count)
    XCTAssertEqual(17, random.largeID(.charset64).count)
    XCTAssertEqual(20, random.largeID(.charset32).count)
    XCTAssertEqual(25, random.largeID(.charset16).count)
    XCTAssertEqual(33, random.largeID(.charset8).count)
    XCTAssertEqual(50, random.largeID(.charset4).count)
    XCTAssertEqual(99, random.largeID(.charset2).count)
    
    for charset in charsets {
      let largeIDBits = Float(99)
      let random = Entropy(charset)
      let id = random.largeID()
      let count = Int(ceilf(largeIDBits / Float(charset.bitsPerChar)))
      XCTAssertEqual(id.count, count)
    }
  }
  
  func testSessionID() {
    random = Entropy()
    XCTAssertEqual( 26, random.sessionID().count)
    XCTAssertEqual( 22, random.sessionID(.charset64).count)
    XCTAssertEqual( 26, random.sessionID(.charset32).count)
    XCTAssertEqual( 32, random.sessionID(.charset16).count)
    XCTAssertEqual( 43, random.sessionID(.charset8).count)
    XCTAssertEqual( 64, random.sessionID(.charset4).count)
    XCTAssertEqual(128, random.sessionID(.charset2).count)
    
    for charset in charsets {
      let sessionIDBits = Float(128)
      let random = Entropy(charset)
      let id = random.sessionID()
      let count = Int(ceilf(sessionIDBits / Float(charset.bitsPerChar)))
      XCTAssertEqual(id.count, count)
    }
  }
    
  func testToken() {
    random = Entropy()
    XCTAssertEqual( 52, random.token().count)
    XCTAssertEqual( 43, random.token(.charset64).count)
    XCTAssertEqual( 52, random.token(.charset32).count)
    XCTAssertEqual( 64, random.token(.charset16).count)
    XCTAssertEqual( 86, random.token(.charset8).count)
    XCTAssertEqual(128, random.token(.charset4).count)
    XCTAssertEqual(256, random.token(.charset2).count)
    
    for charset in charsets {
      let tokenBits = Float(256)
      let random = Entropy(charset)
      let id = random.token()
      let count = Int(ceilf(tokenBits / Float(charset.bitsPerChar)))
      XCTAssertEqual(id.count, count)
    }
  }
  
  func testCharSet64() {
    random = Entropy(.charset64)
    entropyString( 6, [0xdd],                                                 "3")
    entropyString(12, [0x78, 0xfc],                                           "eP")
    entropyString(18, [0xc5, 0x6f, 0x21],                                     "xW8")
    entropyString(24, [0xc9, 0x68, 0xc7],                                     "yWjH")
    entropyString(30, [0xa5, 0x62, 0x20, 0x87],                               "pWIgh")
    entropyString(36, [0x39, 0x51, 0xca, 0xcc, 0x8b],                         "OVHKzI")
    entropyString(42, [0x83, 0x89, 0x00, 0xc7, 0xf4, 0x02],                   "g4kAx_Q")
    entropyString(48, [0x51, 0xbc, 0xa8, 0xc7, 0xc9, 0x17],                   "Ubyox8kX")
    entropyString(54, [0xd2, 0xe3, 0xe9, 0xda, 0x19, 0x97, 0x52],             "0uPp2hmXU")
    entropyString(60, [0xd9, 0x39, 0xc1, 0xaf, 0x1e, 0x2e, 0x69, 0x48],       "2TnBrx4uaU")
    entropyString(66, [0x78, 0x3f, 0xfd, 0x93, 0xd1, 0x06, 0x90, 0x4b, 0xd6], "eD_9k9EGkEv")
    entropyString(72, [0x9d, 0x99, 0x4e, 0xa5, 0xd2, 0x3f, 0x8c, 0x86, 0x80], "nZlOpdI_jIaA")
  }

  func testCharSet32() {
    random = Entropy(.charset32)
    entropyString( 5, [0xdd],                                     "N")
    entropyString(10, [0x78, 0xfc],                               "p6")
    entropyString(15, [0x78, 0xfc],                               "p6R")
    entropyString(20, [0xc5, 0x6f, 0x21],                         "JFHt")
    entropyString(25, [0xa5, 0x62, 0x20, 0x87],                   "DFr43")
    entropyString(30, [0xa5, 0x62, 0x20, 0x87],                   "DFr433")
    entropyString(35, [0x39, 0x51, 0xca, 0xcc, 0x8b],             "b8dPFB7")
    entropyString(40, [0x39, 0x51, 0xca, 0xcc, 0x8b],             "b8dPFB7h")
    entropyString(45, [0x83, 0x89, 0x00, 0xc7, 0xf4, 0x02],       "qn7q3rTD2")
    entropyString(50, [0xd2, 0xe3, 0xe9, 0xda, 0x19, 0x97, 0x52], "MhrRBGqLtQ")
    entropyString(55, [0xd2, 0xe3, 0xe9, 0xda, 0x19, 0x97, 0x52], "MhrRBGqLtQf")
  }

  func testCharSet16() {
    random = Entropy(.charset16)
    entropyString( 4, [0x9d],             "9")
    entropyString( 8, [0xae],             "ae")
    entropyString(12, [0x01, 0xf2],       "01f")
    entropyString(16, [0xc7, 0xc9],       "c7c9")
    entropyString(20, [0xc7, 0xc9, 0x00], "c7c90")
  }
  
  func testCharSet8() {
    random = Entropy(.charset8)
    entropyString( 3, [0x5a],                   "2")
    entropyString( 6, [0x5a],                   "26")
    entropyString( 9, [0x21, 0xa4],             "103")
    entropyString(12, [0x21, 0xa4],             "1032")
    entropyString(15, [0xda, 0x19],             "66414")
    entropyString(18, [0xfd, 0x93, 0xd1],       "773117")
    entropyString(21, [0xfd, 0x93, 0xd1],       "7731172")
    entropyString(24, [0xfd, 0x93, 0xd1],       "77311721")
    entropyString(27, [0xc7, 0xc9, 0x07, 0xc9], "617444076")
    entropyString(30, [0xc7, 0xc9, 0x07, 0xc9], "6174440762")
  }
  
  func testCharSet4() {
    random = Entropy(.charset4)
    entropyString( 2, [0x5a],       "T")
    entropyString( 4, [0x5a],       "TT")
    entropyString( 6, [0x93],       "CTA")
    entropyString( 8, [0x93],       "CTAG")
    entropyString(10, [0x20, 0xf1], "ACAAG")
    entropyString(12, [0x20, 0xf1], "ACAAGG")
    entropyString(14, [0x20, 0xf1], "ACAAGGA")
    entropyString(16, [0x20, 0xf1], "ACAAGGAT")
  }
  
  func testCharSet2() {
    random = Entropy(.charset2)
    entropyString( 1, [0x27],       "0")
    entropyString( 2, [0x27],       "00")
    entropyString( 3, [0x27],       "001")
    entropyString( 4, [0x27],       "0010")
    entropyString( 5, [0x27],       "00100")
    entropyString( 6, [0x27],       "001001")
    entropyString( 7, [0x27],       "0010011")
    entropyString( 8, [0x27],       "00100111")
    entropyString( 9, [0xe3, 0xe9], "111000111")
    entropyString(16, [0xe3, 0xe9], "1110001111101001")
  }
  
  func testStringLengths() {
    for charset in charsets {
      let random = Entropy(charset)
      let iters = 128
      for i in 0 ..< iters {
        let string = random.string(bits: Float(i))
        let count = string.count
        let expected: Int = Int(ceil(Float(i) / Float(charset.bitsPerChar)))
        XCTAssertEqual(count, expected)
      }
    }
  }
  
  func testCustomChars() {
    var random: Entropy
    var string: String
    do {
      random = try Entropy("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ9876543210_-")
      string = try random.string(bits: 72, using: [0x9d, 0x99, 0x4e, 0xa5, 0xd2, 0x3f, 0x8c, 0x86, 0x80])
      XCTAssertEqual(string, "NzLoPDi-JiAa")
      
      random = try Entropy("2346789BDFGHJMNPQRTbdfghjlmnpqrt")
      string = try random.string(bits: 55, using: [0xd2, 0xe3, 0xe9, 0xda, 0x19, 0x97, 0x52])
      XCTAssertEqual(string, "mHRrbgQlTqF")

      random = try Entropy("0123456789ABCDEF")
      string = try random.string(bits: 20, using: [0xc7, 0xc9, 0x00])
      XCTAssertEqual(string, "C7C90")
      
      random = try Entropy("abcdefgh")
      string = try random.string(bits: 30, using: [0xc7, 0xc9, 0x07, 0xc9])
      XCTAssertEqual(string, "gbheeeahgc")

      random = try Entropy("atcg")
      string = try random.string(bits: 16, using: [0x20, 0xf1])
      XCTAssertEqual(string, "acaaggat")

      random = try Entropy("HT")
      string = try random.string(bits: 16, using: [0xe3, 0xe9])
      XCTAssertEqual(string, "TTTHHHTTTTTHTHHT")
    }
    catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testInvalidCharCount() {
    invalidCharCount("")
    invalidCharCount("1")
    invalidCharCount("123")
    invalidCharCount("1234567")
    invalidCharCount("123456789")
    invalidCharCount("1234567890abcde")
    invalidCharCount("1234567890abcdefg")
    invalidCharCount("1234567890abcdefghijklmnopqrstu")
    invalidCharCount("1234567890abcdefghijklmnopqrstuvw")
    invalidCharCount("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-")
    invalidCharCount("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_&")
  }
  
  func testNonUniqueChars() {
    nonUniqueChars("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ab")
    nonUniqueChars("01234567890123456789012345678901")
    nonUniqueChars("0123456789abcd3f")
    nonUniqueChars("01233456")
    nonUniqueChars("0120")
    nonUniqueChars("TT")
  }
  
  func testInvalidBytes() {
    invalidBytes( 7, .charset64, [1])
    invalidBytes(13, .charset64, [1,2])
    invalidBytes(25, .charset64, [1,2,3])
    invalidBytes(31, .charset64, [1,2,3,4])
    
    invalidBytes( 6, .charset32, [1])
    invalidBytes(16, .charset32, [1,2])
    invalidBytes(21, .charset32, [1,2,3])
    invalidBytes(31, .charset32, [1,2,3,4])
    invalidBytes(41, .charset32, [1,2,3,4,5])
    invalidBytes(46, .charset32, [1,2,3,4,5,6])
    
    invalidBytes( 9, .charset16, [1])
    invalidBytes(17, .charset16, [1,2])
    
    invalidBytes( 7, .charset8,  [1])
    invalidBytes(16, .charset8,  [1,2])
    invalidBytes(25, .charset8,  [1,2,3])
    invalidBytes(31, .charset8,  [1,2,3,4])
    
    invalidBytes( 9, .charset4,  [1])
    invalidBytes(17, .charset4,  [1,2])
    
    invalidBytes( 9, .charset2,  [1])
    invalidBytes(17, .charset2,  [1,2])
  }
  
  func testNegativeEntropy() {
    do {
      let random = Entropy(.charset32)
      let _ = try random.string(bits: -6, using: [0x33])
    }
    catch {
      if let error = error as? EntropyStringError {
        XCTAssertEqual(error, EntropyStringError.negativeEntropy)
      }
      else {
        XCTFail("Error not a EntropyStringError")
      }
    }
  }
  
  func testUseCharSet() {
    random = Entropy(.charset32)
    XCTAssertEqual(random.charset.chars, CharSet.charset32.chars)
    random.use(.charset16)
    XCTAssertEqual(random.charset.chars, CharSet.charset16.chars)
  }
  
  func testUseChars() {
    random = try! Entropy("abce")
    XCTAssertEqual(random.charset.chars, "abce")
    try! random.use("ECBA")
    XCTAssertEqual(random.charset.chars, "ECBA")
  }

  #if !os(Linux)
  func testSecRand() {
    for charset in charsets {
      let random = Entropy(charset)
      var secRand = false
      _ = random.string(bits: 36, secRand: &secRand)
      XCTAssertFalse(secRand)
      
      secRand = true
      _ = random.string(bits: 36, secRand: &secRand)
      XCTAssertTrue(secRand)
    }
  }
  #endif

  func entropyString(_ bits: Float, _ bytes: [UInt8], _ expected: String) {
    do {
      let string = try random.string(bits: bits, using: bytes)
      XCTAssertEqual(string, expected)
    }
    catch {
      XCTFail(error.localizedDescription)
    }
  }

  func entropyString(_ bits: Float, _ charset: CharSet, _ bytes: [UInt8], _ expected: String) {
    do {
      let random = Entropy(charset)
      let string = try random.string(bits: bits, using: bytes)
      XCTAssertEqual(string, expected)
    }
    catch {
      XCTFail(error.localizedDescription)
    }
  }

  func nonUniqueChars(_ chars: String) {
    do {
      let _ = try Entropy(chars)
      XCTFail("Should have thrown")
    }
    catch {
      if let error = error as? EntropyStringError {
        XCTAssertEqual(error, EntropyStringError.charsNotUnique)
      }
      else {
        XCTFail("Error not a EntropyStringError")
      }
    }
  }

  func invalidCharCount(_ chars: String) {
    do {
      let _ = try Entropy(chars)
      XCTFail("Should have thrown")
    }
    catch {
      if let error = error as? EntropyStringError {
        XCTAssertEqual(error, EntropyStringError.invalidCharCount)
      }
      else {
        XCTFail("Error not a EntropyStringError")
      }
    }
  }
  
  func invalidBytes(_ bits: Float, _ charset: CharSet, _ bytes: [UInt8]) {
    do {
      let random = Entropy(charset)
      _ = try random.string(bits: bits, using: bytes)
      XCTFail("Should have thrown")
    }
    catch {
      if let error = error as? EntropyStringError {
        XCTAssertEqual(error, EntropyStringError.tooFewBytes)
      }
      else {
        XCTFail("Error not a EntropyStringError")
      }
    }
  }
}

extension EntropyTests {
// Adopt XCTestCaseProvider to run test on  Linux
  static var tests: [(String, (EntropyTests) -> () throws -> ())] {
    return [
      ("testInit",             testInit),
      ("testZeroEntropy",      testZeroEntropy),
      ("testBitsIntInt",       testBitsIntInt),
      ("testBitsIntFloat",     testBitsIntFloat),
      ("testBitsFloatFloat",   testBitsFloatFloat),
      ("testPreshing32Bit",    testPreshing32Bit),
      ("testPreshing64Bit",    testPreshing64Bit),
      ("testPreshing160Bit",   testPreshing160Bit),
      ("testSessionID",        testSessionID),
      ("testCharSet64",        testCharSet64),
      ("testCharSet32",        testCharSet32),
      ("testCharSet16",        testCharSet16),
      ("testCharSet8",         testCharSet8),
      ("testCharSet4",         testCharSet4),
      ("testCharSet2",         testCharSet2),
      ("testStringLengths",    testStringLengths),
      ("testCustomChars",      testCustomChars),
      ("testInvalidCharCount", testInvalidCharCount),
      ("testNonUniqueChars",   testNonUniqueChars),
      ("testInvalidBytes",     testInvalidBytes),
      ("testNegativeEntropy",  testNegativeEntropy)
    ]
  }
}
