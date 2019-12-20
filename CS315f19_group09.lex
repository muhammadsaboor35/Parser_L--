%option yylineno

digit	[0-9]
letter	[a-zA-Z]
alphanumeric [a-zA-Z0-9]
escaped	\\\"

%%
#.*							return(COMMENT);
main						return(MAIN);
true						return(TRUE);
false						return(FALSE);
int							return(INT);
bool						return(BOOL);
string						return(STRING);
conn						return(CONN);
void						return(VOID);
final						return(FINAL);
if							return(IF);
else						return(ELSE);
for							return(FOR);
while						return(WHILE);
return						return(RETURN);
puts						return(PUTS);
gets						return(GETS);
length						return(LENGTH);
str							return(STR);
getState					return(GET_STATE);
switchOn					return(SWITCH_ON);
switchOff					return(SWITCH_OFF);
sendData					return(SEND_DATA);
receiveData					return(RECEIVE_DATA);
formatTime					return(FORMAT_TIME);
formatTemperature			return(FORMAT_TEMPERATURE);
formatHumidity				return(FORMAT_HUMIDITY);
formatAirPressure			return(FORMAT_AIR_PRESSURE);
formatAirQuality			return(FORMAT_AIR_QUALITY);
formatLight					return(FORMAT_LIGHT);
formatSoundLevel			return(FORMAT_SOUND_LEVEL);
formatUltrasonic			return(FORMAT_ULTRASONIC);
formatInfrared				return(FORMAT_INFRARED);
formatGyroX					return(FORMAT_GYRO_X);
formatGyroY					return(FORMAT_GYRO_Y);
formatGyroZ					return(FORMAT_GYRO_Z);
formatSmoke					return(FORMAT_SMOKE);
formatGPSLong				return(FORMAT_GPS_LONG);
formatGPSLat				return(FORMAT_GPS_LAT);
readTime					return(READ_TIME);
readTemperature				return(READ_TEMPERATURE);
readHumidity				return(READ_HUMIDITY);
readAirPressure				return(READ_AIR_PRESSURE);
readAirQuality				return(READ_AIR_QUALITY);
readLight					return(READ_LIGHT);
readSoundLevel				return(READ_SOUND_LEVEL);
readUltrasonic				return(READ_ULTRASONIC);
readInfrared				return(READ_INFRARED);
readGyroX					return(READ_GYRO_X);
readGyroY					return(READ_GYRO_Y);
readGyroZ					return(READ_GYRO_Z);
readSmoke					return(READ_SMOKE);
readGPSLong					return(READ_GPS_LONG);
readGPSLat					return(READ_GPS_LAT);
build_conn					return(BUILD_CONN);
close_conn					return(CLOSE_CONN);
\*\*						return(EXP_OP);
\*							return(MULT_OP);
\/							return(DIV_OP);
&							return(AND_OP);
\|							return(OR_OP);
\^							return(XOR_OP);
!							return(NOT_OP);
>							return(GT_OP);
\<							return(LT_OP);
>=							return(GTE_OP);
\<=							return(LTE_OP);
==							return(EQ_OP);
!=							return(NEQ_OP);
\;							return(SEMI_COLON);
\.							return(DOT);
\(							return(L_PARA);
\)							return(R_PARA);
\{							return(L_CURL);
\}							return(R_CURL);
,							return(COMMA);
=							return(ASSIGN_OP);
(\+\+)							return(INC_OP);
(--)							return(DEC_OP);
\+							return(PLUS);
-							return(MINUS);
{digit}+					return(INTEGER); /*sscanf*/
{letter}({alphanumeric}|_)*	return(VARIABLE);/*  */
\"([^\n\\\"]|\\.)*\"		return(STRING_LIT);
[ \t\n]						;
.							return(yytext[0]);

%%
int yywrap() { return 1; }

