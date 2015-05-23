
#import <Foundation/Foundation.h>

@interface NSString (catagories)

-(BOOL)validateEmail;
-(BOOL)stringIsEmpty;
-(NSString *)DBSingleQuata;
-(NSDate *)DateFromStringFormat:(NSString *)Format;
-(id)GetJSON;
-(NSString *)URLEncode;
-(NSString *)URLENCODEING;

-(NSString *)stringByConvertingHTMLToPlainText;
-(NSString *)stringByDecodingHTMLEntities;
-(NSString *)stringByEncodingHTMLEntities;
-(NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode;
-(NSString *)stringWithNewLinesAsBRs;
-(NSString *)stringByRemovingNewLinesAndWhitespace;
-(NSString *)stringByLinkifyingURLs;
-(NSString *)stringByStrippingTags __attribute__((deprecated));

-(NSString *)stringByDecodingXMLEntities;
-(NSString *)stringByEncodingXMLEntities;

-(NSString *)gtm_stringByEscapingForHTML;
-(NSString *)gtm_stringByEscapingForAsciiHTML;
-(NSString *)gtm_stringByUnescapingFromHTML;

@end
