//------------------------------------------------------------------------------
//
// Android JNI Interface for Pascal/Delphi

//   [Lazarus Support by jmpessoa@hotmail.com - december 2013]
//    https://github.com/jmpessoa/lazandroidmodulewizard

//   Developer
//              Simon,Choi / Choi,Won-sik ,
//                           simonsayz@naver.com   
//                           http://blog.naver.com/simonsayz
//
//              LoadMan    / Jang,Yang-Ho ,
//                           wkddidgh@naver.com    
//                           http://blog.naver.com/wkddidgh 
//
//
//   History    2012.02.24 Started
//              2012.03.01 added unZip,ImageView
//              2012.07.27 fixed _jString null
//
//              see the And_Controls.pas for full history
//
//   Reference  https://github.com/alrieckert/lazarus/tree/master/lcl/interfaces/customdrawn/android
//------------------------------------------------------------------------------

unit And_jni_Bridge;

{$mode delphi}
{$packrecords c}

{$SMARTLINK ON}

interface

uses
  SysUtils,Classes, And_jni, AndroidWidget;

  //{$linklib jnigraphics}   {commented by jmpessoa}

(*
Const
 libjnigraphics  ='libjnigraphics.so'; {commented by jmpessoa}
 ANDROID_BITMAP_RESUT_SUCCESS            =  0;
 ANDROID_BITMAP_RESULT_BAD_PARAMETER     = -1;
 ANDROID_BITMAP_RESULT_JNI_EXCEPTION     = -2;
 ANDROID_BITMAP_RESULT_ALLOCATION_FAILED = -3;

Type
 AndroidBitmapFormat = (ANDROID_BITMAP_FORMAT_NONE      = 0,
                        ANDROID_BITMAP_FORMAT_RGBA_8888 = 1,
                        ANDROID_BITMAP_FORMAT_RGB_565   = 4,
                        ANDROID_BITMAP_FORMAT_RGBA_4444 = 7,
                        ANDROID_BITMAP_FORMAT_A_8       = 8);
 AndroidBitmapInfo   = record
                        width  : Cardinal; //uint32_t;
                        height : Cardinal; //uint32_t
                        stride : Cardinal; //uint32_t
                        format : Integer;  //int32_t
                        flags  : Cardinal; //uint32_t      // 0 for now
                       end;
 PAndroidBitmapInfo = ^AndroidBitmapInfo;
 *)

type


 TWH = Record
        Width : Integer;
        Height: Integer;
       End;

 {
     jboolean=byte;        // unsigned 8 bits
     jbyte=shortint;       // signed 8 bits
     jchar=word;           // unsigned 16 bits
     jshort=smallint;      // signed 16 bits
     jint=longint;         // signed 32 bits
     jlong=int64;          // signed 64 bits
     jfloat=single;        // 32-bit IEEE 754
     jdouble=double;       // 64-bit IEEE 754
 }

 //by jmpessoa
 TDynArrayOfSmallint = array of smallint;

 TDynArrayOfInteger = array of integer;

 TDynArrayOfLongint = array of longint;
 TDynArrayOfDouble = array of double;
 TDynArrayOfSingle = array of single;
 TDynArrayOfInt64  = array of int64;
 TDynArrayOfString = array of string;

 TDynArrayOfJChar = array of JChar;
 TDynArrayOfJBoolean = array of JBoolean;
 TDynArrayOfJByte = array of JByte;

 TArrayOfByte = array of JByte;

 TScanByte = Array[0..0] of JByte;  //by jmpessoa
 PScanByte = ^TScanByte;

 TScanLine = Array[0..0] of DWord;
 PScanLine = ^TScanline;

// Utility

procedure dbg(str : String); overload;
procedure dbg(obj : jObject; objName : String); overload;

// Jni
//function  JNI_OnLoad                   (vm:PJavaVM;reserved:pointer):jint; cdecl;
//procedure JNI_OnUnload                 (vm:PJavaVM;reserved:pointer); cdecl;

// Base
//Please, use jForm_getLength [jmpessoa]
//Function  jStr_getLength               (env:PJNIEnv;this:jobject; Str : String): Integer;


Function  jgetTick                     (env:PJNIEnv;this:jobject) : LongInt;

// System
Procedure jSystem_GC                   (env:PJNIEnv;this:jobject);

//by jmpessoa
Procedure jSystem_GC2                   (env:PJNIEnv;this:jobject);


// Class
Procedure jClass_setNull               (env:PJNIEnv;this:jobject; ClassObj : jClass);
Procedure jClass_chkNull               (env:PJNIEnv;this:jobject; ClassObj : jClass);

// Asset
Function  jAsset_SaveToFile            (env:PJNIEnv; this:jobject; src,dst:String) : Boolean;
//
//

// Image
Function  jImage_getWH                 (env:PJNIEnv;this:jobject; filename : String ) : TWH;
Function  jImage_resample              (env:PJNIEnv;this:jobject; filename : String; size : integer ) : jObject;
Procedure jImage_save                  (env:PJNIEnv;this:jobject; Bitmap : jObject; filename : String);

// TextView 
Function  jTextView_Create             (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;
//by jmpessoa
Function  jTextView_Create2             (env:PJNIEnv;this:jobject; SelfObj: TObject ): jObject;

Procedure jTextView_Free               (env:PJNIEnv;this:jobject; TextView : jObject);

//by jmpessoa
Procedure jTextView_Free2               (env:PJNIEnv;this:jobject; TextView : jObject);
//
Procedure jTextView_setEnabled         (env:PJNIEnv;this:jobject;
                                        TextView : jObject; enabled : Boolean);
Procedure jTextView_setXYWH            (env:PJNIEnv;this:jobject;
                                        TextView : jObject;x,y,w,h : integer);
Procedure jTextView_setParent          (env:PJNIEnv;this:jobject;
                                        TextView : jObject;ViewGroup : jObject);

Procedure jTextView_setParent2          (env:PJNIEnv;this:jobject;
                                        TextView : jObject;ViewGroup : jObject);

//by jmpessoa
Procedure jTextView_setParent3         (env:PJNIEnv;this:jobject;
                                        TextView : jObject; ViewGroup : jObject);

Function  jTextView_getText            (env:PJNIEnv;this:jobject; TextView : jObject) : String;

Function  jTextView_getText2            (env:PJNIEnv;this:jobject; TextView : jObject) : String;

Procedure jTextView_setText            (env:PJNIEnv;this:jobject; TextView : jObject; Str : String);

Procedure jTextView_setText2            (env:PJNIEnv;this:jobject; TextView : jObject; Str : String);

Procedure jTextView_setTextColor       (env:PJNIEnv;this:jobject; TextView : jObject; color : DWord);

//by jmpessoa
Procedure jTextView_setTextColor2       (env:PJNIEnv;this:jobject; TextView : jObject; color : DWord);

Procedure jTextView_setTextSize        (env:PJNIEnv;this:jobject; TextView : jObject; size  : DWord);

//by jmpessoa
Procedure jTextView_setTextSize2        (env:PJNIEnv;this:jobject; TextView : jObject; size  : DWord);
Procedure jTextView_SetTextTypeFace     (env:PJNIEnv;this:jobject; TextView : jObject; value  : DWord);


Procedure jTextView_setTextAlignment   (env:PJNIEnv;this:jobject; TextView : jObject; align : DWord);
//by jmpessoa
Procedure jTextView_setLParamWidth(env:PJNIEnv;this:jobject; TextView : jObject; w: DWord);

Procedure jTextView_setLParamWidth2(env:PJNIEnv;this:jobject; TextView : jObject; w: DWord);

Procedure jTextView_setLParamHeight(env:PJNIEnv;this:jobject; TextView : jObject; h: DWord);

Procedure jTextView_setLParamHeight2(env:PJNIEnv;this:jobject; TextView : jObject; h: DWord);

Procedure jTextView_addLParamsParentRule(env:PJNIEnv;this:jobject; TextView : jObject; rule: DWord);
Procedure jTextView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; TextView : jObject; rule: DWord);

Procedure jTextView_setLayoutAll(env:PJNIEnv;this:jobject; TextView : jObject; idAnchor: DWord);
Procedure jTextView_setLayoutAll2(env:PJNIEnv;this:jobject; TextView : jObject; idAnchor: DWord);

Procedure jTextView_setId(env:PJNIEnv;this:jobject; TextView : jObject; id: DWord);
Procedure jTextView_setId2(env:PJNIEnv;this:jobject; TextView : jObject; id: DWord);

Procedure jTextView_setMarginLeft(env:PJNIEnv;this:jobject; TextView : jObject; x: DWord);
Procedure jTextView_setMarginTop(env:PJNIEnv;this:jobject; TextView : jObject; y: DWord);
Procedure jTextView_setMarginRight(env:PJNIEnv;this:jobject; TextView : jObject; x: DWord);
Procedure jTextView_setMarginBottom(env:PJNIEnv;this:jobject; TextView : jObject; y: DWord);
Procedure jTextView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        TextView : jObject; ml,mt,mr,mb,w,h: integer);

//by jmpessoa
Procedure jTextView_SetVisible(env:PJNIEnv;this:jobject; TextView : jObject; visible : Boolean);


// EditText
Function  jEditText_Create             (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;

//by jmpessoa
Function  jEditText_Create2             (env:PJNIEnv;this:jobject; SelfObj: TObject ): jObject;

Procedure jEditText_Free               (env:PJNIEnv;this:jobject; EditText : jObject);

//by jmpessoa
Procedure jEditText_Free2               (env:PJNIEnv;this:jobject; EditText : jObject);
//
Procedure jEditText_setXYWH            (env:PJNIEnv;this:jobject;
                                        EditText : jObject;x,y,w,h : integer);
Procedure jEditText_setParent          (env:PJNIEnv;this:jobject;
                                        EditText : jObject;ViewGroup : jObject);
//by jmpessoa
Procedure jEditText_setParent2(env:PJNIEnv; this:jobject; EditText: jObject; ViewGroup: jObject);

Function  jEditText_getText            (env:PJNIEnv;this:jobject; EditText : jObject) : String;
//by jmpessoa
Function  jEditText_getText2            (env:PJNIEnv;this:jobject; EditText : jObject) : String;

Procedure jEditText_setText            (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);
//by jmpessoa
Procedure jEditText_setText2            (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);

Procedure jEditText_setTextColor       (env:PJNIEnv;this:jobject; EditText : jObject; color : DWord);
Procedure jEditText_setTextColor2       (env:PJNIEnv;this:jobject; EditText : jObject; color : DWord);

Procedure jEditText_setTextSize        (env:PJNIEnv;this:jobject; EditText : jObject; size  : DWord);
Procedure jEditText_setTextSize2        (env:PJNIEnv;this:jobject; EditText : jObject; size  : DWord);

Procedure jEditText_setHint            (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);
Procedure jEditText_setHint2            (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);

Procedure jEditText_SetFocus           (env:PJNIEnv;this:jobject; EditText : jObject);

Procedure jEditText_SetFocus2           (env:PJNIEnv;this:jobject; EditText : jObject);

Procedure jEditText_immShow            (env:PJNIEnv;this:jobject; EditText : jObject );
Procedure jEditText_immShow2            (env:PJNIEnv;this:jobject; EditText : jObject );

Procedure jEditText_immHide            (env:PJNIEnv;this:jobject; EditText : jObject );
Procedure jEditText_immHide2            (env:PJNIEnv;this:jobject; EditText : jObject );

Procedure jEditText_editInputType      (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);

Procedure jEditText_editInputType2      (env:PJNIEnv;this:jobject; EditText : jObject; Str : String);

Procedure jEditText_editInputTypeEx   (env:PJNIEnv;this:jobject; EditText : jObject; itType : DWord);
Procedure jEditText_editInputTypeEx2  (env:PJNIEnv; this:jobject; EditText: jObject; itType: DWord);

Procedure jEditText_maxLength          (env:PJNIEnv;this:jobject; EditText : jObject; size  : DWord);

//by jmpessoa
Procedure jEditText_setMaxLines(env:PJNIEnv;this:jobject; EditText : jObject; max: DWord);

Procedure jEditText_setLParamWidth(env:PJNIEnv;this:jobject; EditText : jObject; w: DWord);
Procedure jEditText_setLParamWidth2(env:PJNIEnv;this:jobject; EditText : jObject; w: DWord);

Procedure jEditText_setLParamHeight(env:PJNIEnv;this:jobject; EditText : jObject; h: DWord);
Procedure jEditText_setLParamHeight2(env:PJNIEnv;this:jobject; EditText : jObject; h: DWord);

Procedure jEditText_addLParamsParentRule(env:PJNIEnv;this:jobject; EditText : jObject; rule: DWord);
Procedure jEditText_addLParamsAnchorRule(env:PJNIEnv;this:jobject; EditText : jObject; rule: DWord);

Procedure jEditText_setLayoutAll(env:PJNIEnv;this:jobject; EditText : jObject; idAnchor: DWord);
Procedure jEditText_setLayoutAll2(env:PJNIEnv;this:jobject; EditText : jObject; idAnchor: DWord);

Procedure jEditText_setId(env:PJNIEnv;this:jobject; EditText : jObject; id: DWord);

Procedure jEditText_setMarginLeft(env:PJNIEnv;this:jobject; EditText : jObject; x: DWord);
Procedure jEditText_setMarginTop(env:PJNIEnv;this:jobject; EditText : jObject; y: DWord);
Procedure jEditText_setMarginRight(env:PJNIEnv;this:jobject; EditText : jObject; x: DWord);
Procedure jEditText_setMarginBottom(env:PJNIEnv;this:jobject; EditText : jObject; y: DWord);
Procedure jEditText_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        EditText : jObject; ml,mt,mr,mb,w,h: integer);
//
Procedure jEditText_setSingleLine(env:PJNIEnv;this:jobject; EditText : jObject; isSingle  : boolean);

Procedure jEditText_setSingleLine2(env:PJNIEnv;this:jobject; EditText : jObject; isSingle  : boolean);

Procedure jEditText_setHorizontallyScrolling(env:PJNIEnv;this:jobject; EditText : jObject; wrapping: boolean);

Procedure jEditText_setVerticalScrollBarEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);
Procedure jEditText_setHorizontalScrollBarEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);
Procedure jEditText_setScrollbarFadingEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);

Procedure jEditText_setScroller(env:PJNIEnv; this:jobject; context : jObject; EditText: jObject);


Procedure jEditText_setScroller2(env:PJNIEnv; this:jobject; EditText : jObject);

Procedure jEditText_setScrollBarStyle(env:PJNIEnv;this:jobject; EditText : jObject; style  : DWord);
Procedure jEditText_setMovementMethod(env:PJNIEnv;this:jobject; EditText : jObject);

Procedure jEditText_GetCursorPos       (env:PJNIEnv;this:jobject; EditText : jObject; Var x,y : Integer);

Procedure jEditText_GetCursorPos2       (env:PJNIEnv;this:jobject; EditText : jObject; Var x,y : Integer);

Procedure jEditText_SetCursorPos       (env:PJNIEnv;this:jobject; EditText : jObject; startPos, endPos : Integer);
Procedure jEditText_SetCursorPos2       (env:PJNIEnv;this:jobject; EditText : jObject; startPos, endPos : Integer);

Procedure jEditText_setTextAlignment   (env:PJNIEnv;this:jobject; EditText : jObject; align : DWord);
Procedure jEditText_SetEnabled         (env:PJNIEnv;this:jobject; EditText : jObject; enabled : Boolean);
Procedure jEditText_SetEditable        (env:PJNIEnv;this:jobject; EditText : jObject; enabled : Boolean);

// Button
Function  jButton_Create               (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;
//by jmpessoa
Function  jButton_Create2              (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jButton_Free                 (env:PJNIEnv;this:jobject; Button : jObject);

//by jmpessoa
Procedure jButton_Free2                 (env:PJNIEnv;this:jobject; Button : jObject);
//

Procedure jButton_setXYWH              (env:PJNIEnv;this:jobject;
                                        Button : jObject;x,y,w,h : integer);

Procedure jButton_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        Button : jObject; ml,mt,mr,mb,w,h: integer);


Procedure jButton_setParent            (env:PJNIEnv;this:jobject;
                                        Button : jObject;ViewGroup : jObject);

Procedure jButton_setParent2            (env:PJNIEnv;this:jobject;
                                        Button : jObject;ViewGroup : jObject);

Function  jButton_getText              (env:PJNIEnv;this:jobject; Button : jObject) : String;
Procedure jButton_setText              (env:PJNIEnv;this:jobject; Button : jObject; Str : String);
//by jmpessoa
Procedure jButton_setText2              (env:PJNIEnv;this:jobject; Button : jObject; Str : String);

Procedure jButton_setTextColor         (env:PJNIEnv;this:jobject; Button : jObject; color : DWord);

Procedure jButton_setTextColor2         (env:PJNIEnv;this:jobject; Button : jObject; color : DWord);

Procedure jButton_setTextSize          (env:PJNIEnv;this:jobject; Button : jObject; size  : DWord);

//by jmpessoa
Procedure jButton_addLParamsParentRule(env:PJNIEnv;this:jobject; Button : jObject; rule: DWord);
Procedure jButton_addLParamsAnchorRule(env:PJNIEnv;this:jobject; Button : jObject; rule: DWord);

Procedure jButton_setLayoutAll(env:PJNIEnv;this:jobject; Button : jObject;  idAnchor: DWord);
Procedure jButton_setLayoutAll2(env:PJNIEnv;this:jobject; Button : jObject;  idAnchor: DWord);

Procedure jButton_setLParamWidth(env:PJNIEnv;this:jobject; Button : jObject; w: DWord);
Procedure jButton_setLParamWidth2(env:PJNIEnv;this:jobject; Button : jObject; w: DWord);

Procedure jButton_setLParamHeight(env:PJNIEnv;this:jobject; Button : jObject; h: DWord);
Procedure jButton_setLParamHeight2(env:PJNIEnv;this:jobject; Button : jObject; h: DWord);

Procedure jButton_setId(env:PJNIEnv;this:jobject; Button : jObject; id: DWord);
Procedure jButton_setMarginLeft(env:PJNIEnv;this:jobject; Button : jObject; x: DWord);
Procedure jButton_setMarginTop(env:PJNIEnv;this:jobject; Button : jObject; y: DWord);
Procedure jButton_setMarginRight(env:PJNIEnv;this:jobject; Button : jObject; x: DWord);
Procedure jButton_setMarginBottom(env:PJNIEnv;this:jobject; Button : jObject; y: DWord);

Procedure jButton_setFocusable(env:PJNIEnv;this:jobject; Button : jObject; enabled: boolean);

//
Procedure jButton_setOnClick           (env:PJNIEnv;this:jobject; Button : jObject);


// CheckBox
Function  jCheckBox_Create             (env:PJNIEnv; this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;

//by jmpessoa
Function  jCheckBox_Create2            (env:PJNIEnv; this:jobject; SelfObj: TObject ): jObject;

Procedure jCheckBox_Free               (env:PJNIEnv;this:jobject; CheckBox : jObject);

//by jmpessoa
Procedure jCheckBox_Free2               (env:PJNIEnv;this:jobject; CheckBox : jObject);

//
Procedure jCheckBox_setXYWH            (env:PJNIEnv;this:jobject;
                                        CheckBox : jObject;x,y,w,h : integer);
Procedure jCheckBox_setParent          (env:PJNIEnv;this:jobject;
                                        CheckBox : jObject;ViewGroup : jObject);

Procedure jCheckBox_setParent2          (env:PJNIEnv;this:jobject;
                                        CheckBox : jObject;ViewGroup : jObject);

Function  jCheckBox_getText            (env:PJNIEnv;this:jobject; CheckBox : jObject) : String;
Procedure jCheckBox_setText            (env:PJNIEnv;this:jobject; CheckBox : jObject; Str : String);

Procedure jCheckBox_setText2            (env:PJNIEnv;this:jobject; CheckBox : jObject; Str : String);

Procedure jCheckBox_setTextColor       (env:PJNIEnv;this:jobject; CheckBox : jObject; color : DWord);
Procedure jCheckBox_setTextColor2       (env:PJNIEnv;this:jobject; CheckBox : jObject; color : DWord);
Procedure jCheckBox_setTextSize        (env:PJNIEnv;this:jobject; CheckBox : jObject; size  : DWord);
Function  jCheckBox_isChecked          (env:PJNIEnv;this:jobject; CheckBox : jObject) : Boolean;
Function  jCheckBox_isChecked2          (env:PJNIEnv;this:jobject; CheckBox : jObject) : Boolean;
Procedure jCheckBox_setChecked         (env:PJNIEnv;this:jobject; CheckBox : jObject; value : Boolean);

Procedure jCheckBox_setChecked2         (env:PJNIEnv;this:jobject; CheckBox : jObject; value : Boolean);

//by jmpessoa
Procedure jCheckBox_setId(env:PJNIEnv;this:jobject; CheckBox : jObject; id: DWord);
Procedure jCheckBox_setMarginLeft(env:PJNIEnv;this:jobject; CheckBox : jObject; x: DWord);
Procedure jCheckBox_setMarginTop(env:PJNIEnv;this:jobject; CheckBox : jObject; y: DWord);
Procedure jCheckBox_setMarginRight(env:PJNIEnv;this:jobject; CheckBox : jObject; x: DWord);
Procedure jCheckBox_setMarginBottom(env:PJNIEnv;this:jobject; CheckBox : jObject; y: DWord);

Procedure jCheckBox_setLParamWidth(env:PJNIEnv;this:jobject; CheckBox : jObject; w: DWord);
Procedure jCheckBox_setLParamWidth2(env:PJNIEnv;this:jobject; CheckBox : jObject; w: DWord);

Procedure jCheckBox_setLParamHeight(env:PJNIEnv;this:jobject; CheckBox : jObject; h: DWord);
Procedure jCheckBox_setLParamHeight2(env:PJNIEnv;this:jobject; CheckBox : jObject; h: DWord);

Procedure jCheckBox_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        CheckBox : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jCheckBox_addLParamsParentRule(env:PJNIEnv;this:jobject; CheckBox : jObject; rule: DWord);
Procedure jCheckBox_addLParamsAnchorRule(env:PJNIEnv;this:jobject; CheckBox : jObject; rule: DWord);

Procedure jCheckBox_setLayoutAll(env:PJNIEnv;this:jobject; CheckBox : jObject;  idAnchor: DWord);
Procedure jCheckBox_setLayoutAll2(env:PJNIEnv;this:jobject; CheckBox : jObject;  idAnchor: DWord);

// RadioButton
Function  jRadioButton_Create          (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;

//by jmpessoa
Function  jRadioButton_Create2          (env:PJNIEnv;this:jobject; SelfObj: TObject ): jObject;

Procedure jRadioButton_Free            (env:PJNIEnv;this:jobject; RadioButton : jObject);

Procedure jRadioButton_Free2            (env:PJNIEnv;this:jobject; RadioButton : jObject);
//
Procedure jRadioButton_setXYWH         (env:PJNIEnv;this:jobject;
                                        RadioButton : jObject;x,y,w,h : integer);
Procedure jRadioButton_setParent       (env:PJNIEnv;this:jobject;
                                        RadioButton : jObject;ViewGroup : jObject);
Function  jRadioButton_getText         (env:PJNIEnv;this:jobject; RadioButton : jObject) : String;
Procedure jRadioButton_setText         (env:PJNIEnv;this:jobject; RadioButton : jObject; Str : String);
Procedure jRadioButton_setText2         (env:PJNIEnv;this:jobject; RadioButton : jObject; Str : String);
Procedure jRadioButton_setTextColor    (env:PJNIEnv;this:jobject; RadioButton : jObject; color : DWord);
Procedure jRadioButton_setTextColor2    (env:PJNIEnv;this:jobject; RadioButton : jObject; color : DWord);
Procedure jRadioButton_setTextSize     (env:PJNIEnv;this:jobject; RadioButton : jObject; size  : DWord);
Function  jRadioButton_isChecked       (env:PJNIEnv;this:jobject; RadioButton : jObject) : Boolean;
Function  jRadioButton_isChecked2       (env:PJNIEnv;this:jobject; RadioButton : jObject) : Boolean;
Procedure jRadioButton_setChecked      (env:PJNIEnv;this:jobject; RadioButton : jObject; value : Boolean);

Procedure jRadioButton_setChecked2      (env:PJNIEnv;this:jobject; RadioButton : jObject; value : Boolean);


//====================================

//by jmpessoa
Procedure jRadioButton_setId(env:PJNIEnv;this:jobject; RadioButton : jObject; id: DWord);
Procedure jRadioButton_setMarginLeft(env:PJNIEnv;this:jobject; RadioButton : jObject; x: DWord);
Procedure jRadioButton_setMarginTop(env:PJNIEnv;this:jobject; RadioButton : jObject; y: DWord);
Procedure jRadioButton_setMarginRight(env:PJNIEnv;this:jobject; RadioButton : jObject; x: DWord);
Procedure jRadioButton_setMarginBottom(env:PJNIEnv;this:jobject; RadioButton : jObject; y: DWord);

Procedure jRadioButton_setLParamWidth(env:PJNIEnv;this:jobject; RadioButton : jObject; w: DWord);
Procedure jRadioButton_setLParamWidth2(env:PJNIEnv;this:jobject; RadioButton : jObject; w: DWord);
Procedure jRadioButton_setLParamHeight(env:PJNIEnv;this:jobject; RadioButton : jObject; h: DWord);
Procedure jRadioButton_setLParamHeight2(env:PJNIEnv;this:jobject; RadioButton : jObject; h: DWord);

Procedure jRadioButton_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        RadioButton : jObject; ml,mt,mr,mb,w,h: integer);


Procedure jRadioButton_addLParamsParentRule(env:PJNIEnv;this:jobject; RadioButton : jObject; rule: DWord);
Procedure jRadioButton_addLParamsAnchorRule(env:PJNIEnv;this:jobject; RadioButton : jObject; rule: DWord);
Procedure jRadioButton_setLayoutAll(env:PJNIEnv;this:jobject; RadioButton : jObject;  idAnchor: DWord);

Procedure jRadioButton_setLayoutAll2(env:PJNIEnv;this:jobject; RadioButton : jObject;  idAnchor: DWord);
// ProgressBar
Function  jProgressBar_Create          (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject; Style : DWord ) : jObject;

//by jmpessoa
Function  jProgressBar_Create2          (env:PJNIEnv; this:jobject; SelfObj: TObject; Style: DWord ): jObject;


Procedure jProgressBar_Free            (env:PJNIEnv;this:jobject; ProgressBar : jObject);

Procedure jProgressBar_Free2            (env:PJNIEnv;this:jobject; ProgressBar : jObject);
//
Procedure jProgressBar_setXYWH         (env:PJNIEnv;this:jobject;
                                        ProgressBar : jObject;x,y,w,h : integer);
Procedure jProgressBar_setParent       (env:PJNIEnv;this:jobject;
                                        ProgressBar : jObject;ViewGroup : jObject);

Procedure jProgressBar_setParent2       (env:PJNIEnv;this:jobject;
                                        ProgressBar : jObject;ViewGroup : jObject);

Function  jProgressBar_getProgress     (env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;
//by jmpessoa
Function  jProgressBar_getProgress2     (env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;

Procedure jProgressBar_setProgress     (env:PJNIEnv;this:jobject; ProgressBar : jObject; value : integer);
//by jmpessoa
Procedure jProgressBar_setProgress2     (env:PJNIEnv;this:jobject; ProgressBar : jObject; value : integer);

//by jmpessoa
Procedure jProgressBar_setMax          (env:PJNIEnv;this:jobject; ProgressBar : jObject; value : integer);
Function  jProgressBar_getMax          (env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;
Procedure jProgressBar_setMax2          (env:PJNIEnv;this:jobject; ProgressBar : jObject; value : integer);
Function  jProgressBar_getMax2          (env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;


//by jmpessoa
Procedure jProgressBar_setId(env:PJNIEnv;this:jobject; ProgressBar : jObject; id: DWord);
Procedure jProgressBar_setMarginLeft(env:PJNIEnv;this:jobject; ProgressBar : jObject; x: DWord);
Procedure jProgressBar_setMarginTop(env:PJNIEnv;this:jobject; ProgressBar : jObject; y: DWord);
Procedure jProgressBar_setMarginRight(env:PJNIEnv;this:jobject; ProgressBar : jObject; x: DWord);
Procedure jProgressBar_setMarginBottom(env:PJNIEnv;this:jobject; ProgressBar : jObject; y: DWord);
Procedure jProgressBar_setLParamWidth(env:PJNIEnv;this:jobject; ProgressBar : jObject; w: DWord);
Procedure jProgressBar_setLParamWidth2(env:PJNIEnv;this:jobject; ProgressBar : jObject; w: DWord);
Procedure jProgressBar_setLParamHeight(env:PJNIEnv;this:jobject; ProgressBar : jObject; h: DWord);
Procedure jProgressBar_setLParamHeight2(env:PJNIEnv;this:jobject; ProgressBar : jObject; h: DWord);

Procedure jProgressBar_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ProgressBar : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jProgressBar_addLParamsParentRule(env:PJNIEnv;this:jobject; ProgressBar : jObject; rule: DWord);
Procedure jProgressBar_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ProgressBar : jObject; rule: DWord);
Procedure jProgressBar_setLayoutAll(env:PJNIEnv;this:jobject; ProgressBar : jObject;  idAnchor: DWord);
Procedure jProgressBar_setLayoutAll2(env:PJNIEnv;this:jobject; ProgressBar : jObject;  idAnchor: DWord);

// ImageView
Function  jImageView_Create            (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject) : jObject;

//by jmpessoa
Function  jImageView_Create2            (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jImageView_Free              (env:PJNIEnv;this:jobject; ImageView : jObject);

Procedure jImageView_Free2              (env:PJNIEnv;this:jobject; ImageView : jObject);
//
Procedure jImageView_setXYWH           (env:PJNIEnv;this:jobject;
                                        ImageView : jObject;x,y,w,h : integer);
Procedure jImageView_setParent         (env:PJNIEnv;this:jobject;
                                        ImageView : jObject;ViewGroup : jObject);
Procedure jImageView_setImage          (env:PJNIEnv;this:jobject; 
                                        ImageView : jObject; Str : String);
Procedure jImageView_setImage2          (env:PJNIEnv;this:jobject;
                                        ImageView : jObject; Str : String);

//by jmpessoa
Procedure jImageView_setBitmapImage(env:PJNIEnv;this:jobject;
                                    ImageView : jObject; bitmap : jObject);


Procedure jImageView_setBitmapImage2(env:PJNIEnv;this:jobject;
                                    ImageView : jObject; bitmap : jObject);

Procedure jImageView_SetImageByResIdentifier(env:PJNIEnv;this:jobject; ImageView : jObject; _imageResIdentifier: string);


//by jmpessoa
Procedure jImageView_setId(env:PJNIEnv;this:jobject; ImageView : jObject; id: DWord);
Procedure jImageView_setMarginLeft(env:PJNIEnv;this:jobject; ImageView : jObject; x: DWord);
Procedure jImageView_setMarginTop(env:PJNIEnv;this:jobject; ImageView : jObject; y: DWord);
Procedure jImageView_setMarginRight(env:PJNIEnv;this:jobject; ImageView : jObject; x: DWord);
Procedure jImageView_setMarginBottom(env:PJNIEnv;this:jobject; ImageView : jObject; y: DWord);

Procedure jImageView_setLParamWidth(env:PJNIEnv;this:jobject; ImageView : jObject; w: DWord);
Procedure jImageView_setLParamWidth2(env:PJNIEnv;this:jobject; ImageView : jObject; w: DWord);

Procedure jImageView_setLParamHeight(env:PJNIEnv;this:jobject; ImageView : jObject; h: DWord);
Procedure jImageView_setLParamHeight2(env:PJNIEnv;this:jobject; ImageView : jObject; h: DWord);

//by jmpessoa
Procedure jImageView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ImageView : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jImageView_addLParamsParentRule(env:PJNIEnv;this:jobject; ImageView : jObject; rule: DWord);
Procedure jImageView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ImageView : jObject; rule: DWord);

Procedure jImageView_setLayoutAll(env:PJNIEnv;this:jobject; ImageView : jObject;  idAnchor: DWord);
Procedure jImageView_setLayoutAll2(env:PJNIEnv;this:jobject; ImageView : jObject;  idAnchor: DWord);

//by jmpessoa
function jImageView_getLParamHeight(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
function jImageView_getLParamWidth(env:PJNIEnv;this:jobject; ImageView : jObject): integer;

function jImageView_getLParamHeight2(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
function jImageView_getLParamWidth2(env:PJNIEnv;this:jobject; ImageView : jObject): integer;

function jImageView_GetBitmapHeight(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
function jImageView_GetBitmapWidth(env:PJNIEnv;this:jobject; ImageView : jObject): integer;

// ListView
Function  jListView_Create             (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject;
                                        hasWidget: integer; delimiter: string) : jObject;

//by jmpessoa
Function  jListView_Create2             (env:PJNIEnv; this:jobject; SelfObj: TObject;
                                         {ftColor: integer; ftSize: integer;} widget: integer;
                                         widgetText: string; image: jObject;
                                         txtDecorated: integer; itemLay: integer; txtSizeDec: integer; txtAlign: integer): jObject;

Function  jListView_Create3             (env:PJNIEnv; this:jobject; SelfObj: TObject;
                                         {ftColor: integer; ftSize: integer;} widget: integer;
                                         widgetText: string;
                                         txtDecorated: integer; itemLay: integer; txtSizeDec: integer; txtAlign: integer): jObject;

Procedure jListView_Free               (env:PJNIEnv;this:jobject; ListView : jObject);

Procedure jListView_Free2               (env:PJNIEnv;this:jobject; ListView : jObject);
//
Procedure jListView_setXYWH            (env:PJNIEnv;this:jobject;
                                        ListView : jObject;x,y,w,h : integer);
Procedure jListView_setParent          (env:PJNIEnv;this:jobject;
                                        ListView : jObject;ViewGroup : jObject);
Procedure jListView_setParent2          (env:PJNIEnv;this:jobject;
                                        ListView : jObject;ViewGroup : jObject);
Procedure jListView_setTextColor       (env:PJNIEnv;this:jobject; ListView : jObject; color : DWord);
Procedure jListView_setTextColor2       (env:PJNIEnv;this:jobject; ListView : jObject; color : DWord; index: integer);

Procedure jListView_setTextSize        (env:PJNIEnv;this:jobject; ListView : jObject; size  : DWord);
Procedure jListView_setTextSize2        (env:PJNIEnv;this:jobject; ListView : jObject; size  : DWord; index: integer);

Procedure jListView_setItemPosition    (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Pos: integer; y:Integer );

Procedure jListView_setItemPosition2    (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Pos: integer; y:Integer );
//
Procedure jListView_add                (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Str : string;
                                        delimiter: string; fontColor: integer; fontSize: integer; hasWidgetItem: integer);
//by jmpessoa
Procedure jListView_add2(env:PJNIEnv;this:jobject; ListView: jObject; Str: string; delimiter: string);

Procedure jListView_add22(env:PJNIEnv;this:jobject; ListView: jObject; Str: string; delimiter: string; image: jObject);

Procedure jListView_add3                (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Str : string;
                                        delimiter: string; fontColor: integer; fontSize: integer;
                                        widgetItem: integer; widgetText: string; image: jObject);

Procedure jListView_add4                (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Str : string;
                                        delimiter: string; fontColor: integer; fontSize: integer;
                                        widgetItem: integer; widgetText: string);


Procedure jListView_clear              (env:PJNIEnv;this:jobject;
                                        ListView : jObject);
//by jmpessoa
Procedure jListView_clear2              (env:PJNIEnv;this:jobject;
                                        ListView : jObject);

Procedure jListView_delete             (env:PJNIEnv;this:jobject;
                                        ListView : jObject; index : integer);

//by jmpessoa
Procedure jListView_delete2             (env:PJNIEnv;this:jobject;
                                        ListView : jObject; index : integer);

//by jmpessoa
Procedure jListView_setId(env:PJNIEnv;this:jobject; ListView : jObject; id: DWord);

Procedure jListView_setWidgetItem(env:PJNIEnv;this:jobject; ListView : jObject; value: integer);

Procedure jListView_setWidgetItem2(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
Procedure jListView_setWidgetItem3(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; txt: string; index: integer);
Procedure jListView_setWidgetText(env:PJNIEnv;this:jobject; ListView : jObject; txt: string; index: integer);

Procedure jListView_setTextDecorated(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
Procedure jListView_setTextSizeDecorated(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index:integer);

Procedure jListView_setItemLayout(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);


Procedure jListView_setImageItem(env:PJNIEnv;this:jobject; ListView : jObject; bitmap: jObject; index: integer); overload;
Procedure jListView_setImageItem(env:PJNIEnv;this:jobject; ListView : jObject; imgResIdentifier: string; index: integer); overload;

Procedure jListView_setTextAlign(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);

function jListView_IsItemChecked(env:PJNIEnv;this:jobject; ListView : jObject; index: integer): boolean;

function jListView_GetItemText(env:PJNIEnv;this:jobject; ListView : jObject; index: integer): string;
function jListView_GetCount(env:PJNIEnv;this:jobject; ListView : jObject): integer;

Procedure jListView_setMarginLeft(env:PJNIEnv;this:jobject; ListView : jObject; x: DWord);
Procedure jListView_setMarginTop(env:PJNIEnv;this:jobject; ListView : jObject; y: DWord);
Procedure jListView_setMarginRight(env:PJNIEnv;this:jobject; ListView : jObject; x: DWord);
Procedure jListView_setMarginBottom(env:PJNIEnv;this:jobject; ListView : jObject; y: DWord);
Procedure jListView_setLParamWidth(env:PJNIEnv;this:jobject; ListView : jObject; w: DWord);
Procedure jListView_setLParamHeight(env:PJNIEnv;this:jobject; ListView : jObject; h: DWord);
Procedure jListView_setLParamWidth2(env:PJNIEnv;this:jobject; ListView : jObject; w: DWord);
Procedure jListView_setLParamHeight2(env:PJNIEnv;this:jobject; ListView : jObject; h: DWord);

Procedure jListView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ListView : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jListView_addLParamsParentRule(env:PJNIEnv;this:jobject; ListView : jObject; rule: DWord);
Procedure jListView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ListView : jObject; rule: DWord);
Procedure jListView_setLayoutAll(env:PJNIEnv;this:jobject; ListView : jObject;  idAnchor: DWord);
Procedure jListView_setLayoutAll2(env:PJNIEnv;this:jobject; ListView : jObject;  idAnchor: DWord);
procedure jListView_SetHighLightSelectedItem(env: PJNIEnv; this: JObject; _jlistview: JObject; _value: boolean);
procedure jListView_SetHighLightSelectedItemColor(env: PJNIEnv; this: JObject; _jlistview: JObject; _color: integer);


// ScrollView
Function  jScrollView_Create           (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject) : jObject;

//by jmpessoa
Function  jScrollView_Create2           (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jScrollView_Free             (env:PJNIEnv;this:jobject; ScrollView : jObject);

Procedure jScrollView_Free2             (env:PJNIEnv;this:jobject; ScrollView : jObject);
//
Procedure jScrollView_setXYWH          (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject;x,y,w,h : integer);
Procedure jScrollView_setParent        (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject;ViewGroup : jObject);

Procedure jScrollView_setParent2        (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject;ViewGroup : jObject);

Procedure jScrollView_setScrollSize    (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; size : integer);

Procedure jScrollView_setScrollSize2    (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; size : integer);

Function  jScrollView_getView          (env:PJNIEnv;this:jobject;
                                        ScrollView : jObject) : jObject;
//by jmpessoa
Procedure jScrollView_setId(env:PJNIEnv;this:jobject; ScrollView : jObject; id: DWord);
Procedure jScrollView_setMarginLeft(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Procedure jScrollView_setMarginTop(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Procedure jScrollView_setMarginRight(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Procedure jScrollView_setMarginBottom(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Procedure jScrollView_setLParamWidth(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Procedure jScrollView_setLParamHeight(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);
Procedure jScrollView_setLParamWidth2(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Procedure jScrollView_setLParamHeight2(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);

Procedure jScrollView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jScrollView_addLParamsParentRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Procedure jScrollView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Procedure jScrollView_setLayoutAll(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
Procedure jScrollView_setLayoutAll2(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
//---------------

// jPanel by jmpessoa
Function  jPanel_Create           (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject) : jObject;
//by jmpessoa
Function  jPanel_Create2           (env:PJNIEnv;this:jobject; SelfObj: TObject): jObject;

Procedure jPanel_Free             (env:PJNIEnv;this:jobject; Panel : jObject);

Procedure jPanel_Free2             (env:PJNIEnv;this:jobject; Panel : jObject);
//
Procedure jPanel_setXYWH          (env:PJNIEnv;this:jobject;
                                        Panel : jObject;x,y,w,h : integer);
Procedure jPanel_setParent        (env:PJNIEnv;this:jobject;
                                        Panel : jObject;ViewGroup : jObject);

Procedure jPanel_setParent2        (env:PJNIEnv;this:jobject;
                                        Panel : jObject;ViewGroup : jObject);

Function  jPanel_getView          (env:PJNIEnv; this:jobject;
                                        Panel : jObject) : jObject;

//by jmpessoa
Procedure jPanel_setId(env:PJNIEnv;this:jobject; Panel : jObject; id: DWord);
Procedure jPanel_setMarginLeft(env:PJNIEnv;this:jobject; Panel : jObject; x: DWord);
Procedure jPanel_setMarginTop(env:PJNIEnv;this:jobject; Panel : jObject; y: DWord);
Procedure jPanel_setMarginRight(env:PJNIEnv;this:jobject; Panel : jObject; x: DWord);
Procedure jPanel_setMarginBottom(env:PJNIEnv;this:jobject; Panel : jObject; y: DWord);
Procedure jPanel_setLParamWidth(env:PJNIEnv;this:jobject; Panel : jObject; w: DWord);
Procedure jPanel_setLParamHeight(env:PJNIEnv;this:jobject; Panel : jObject; h: DWord);

Procedure jPanel_setLParamWidth2(env:PJNIEnv;this:jobject; Panel : jObject; w: DWord);
Procedure jPanel_setLParamHeight2(env:PJNIEnv;this:jobject; Panel : jObject; h: DWord);

Procedure jPanel_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        Panel : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jPanel_resetLParamsRules(env:PJNIEnv;this:jobject; Panel : jObject);

Procedure jPanel_resetLParamsRules2(env:PJNIEnv;this:jobject; Panel : jObject);

Procedure jPanel_addLParamsParentRule(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);

Procedure jPanel_addLParamsParentRule2(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);

Procedure jPanel_addLParamsAnchorRule(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);
Procedure jPanel_addLParamsAnchorRule2(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);

Procedure jPanel_setLayoutAll(env:PJNIEnv;this:jobject; Panel : jObject;  idAnchor: DWord);
Procedure jPanel_setLayoutAll2(env:PJNIEnv;this:jobject; Panel : jObject;  idAnchor: DWord);

Procedure jPanel_RemoveParent(env:PJNIEnv;this:jobject; Panel : jObject);

function jPanel_getLParamHeight(env:PJNIEnv;this:jobject; Panel : jObject ): integer;
function jPanel_getLParamWidth(env:PJNIEnv;this:jobject; Panel : jObject): integer;

function jPanel_getLParamHeight2(env:PJNIEnv;this:jobject; Panel : jObject ): integer;
function jPanel_getLParamWidth2(env:PJNIEnv;this:jobject; Panel : jObject): integer;

//-----------------
// HorizontalScrollView
Function  jHorizontalScrollView_Create        (env:PJNIEnv;this:jobject;
                                               context : jObject; SelfObj : TObject) : jObject;

//by jmpessoa
Function  jHorizontalScrollView_Create2        (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jHorizontalScrollView_Free          (env:PJNIEnv;this:jobject; ScrollView : jObject);

Procedure jHorizontalScrollView_Free2          (env:PJNIEnv;this:jobject; ScrollView : jObject);

Procedure jHorizontalScrollView_setXYWH       (env:PJNIEnv;this:jobject;
                                               ScrollView : jObject;x,y,w,h : integer);
Procedure jHorizontalScrollView_setParent     (env:PJNIEnv;this:jobject;
                                               ScrollView : jObject;ViewGroup : jObject);
Procedure jHorizontalScrollView_setScrollSize (env:PJNIEnv;this:jobject;
                                               ScrollView : jObject; size : integer);

Procedure jHorizontalScrollView_setScrollSize2 (env:PJNIEnv;this:jobject;
                                               ScrollView : jObject; size : integer);

Function  jHorizontalScrollView_getView       (env:PJNIEnv;this:jobject;
                                               ScrollView : jObject) : jObject;

//by jmpessoa
Procedure jHorizontalScrollView_setId(env:PJNIEnv;this:jobject; ScrollView : jObject; id: DWord);
Procedure jHorizontalScrollView_setMarginLeft(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Procedure jHorizontalScrollView_setMarginTop(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Procedure jHorizontalScrollView_setMarginRight(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Procedure jHorizontalScrollView_setMarginBottom(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Procedure jHorizontalScrollView_setLParamWidth(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Procedure jHorizontalScrollView_setLParamHeight(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);
Procedure jHorizontalScrollView_setLParamWidth2(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Procedure jHorizontalScrollView_setLParamHeight2(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);

Procedure jHorizontalScrollView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jHorizontalScrollView_addLParamsParentRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Procedure jHorizontalScrollView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Procedure jHorizontalScrollView_setLayoutAll(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
Procedure jHorizontalScrollView_setLayoutAll2(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);

// ViewFlipper
Function  jViewFlipper_Create          (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;

//by jmpessoa
Function  jViewFlipper_Create2          (env:PJNIEnv; this:jobject; SelfObj: TObject ): jObject;

Procedure jViewFlipper_Free            (env:PJNIEnv;this:jobject; ViewFlipper : jObject);

Procedure jViewFlipper_Free2            (env:PJNIEnv;this:jobject; ViewFlipper : jObject);
//
Procedure jViewFlipper_setXYWH         (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;x,y,w,h : integer);
Procedure jViewFlipper_setParent       (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;ViewGroup : jObject);

Procedure jViewFlipper_setParent2       (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;ViewGroup : jObject);

//by jmpessoa
Procedure jViewFlipper_setId(env:PJNIEnv;this:jobject; ViewFlipper : jObject; id: DWord);
Procedure jViewFlipper_setMarginLeft(env:PJNIEnv;this:jobject; ViewFlipper : jObject; x: DWord);
Procedure jViewFlipper_setMarginTop(env:PJNIEnv;this:jobject; ViewFlipper : jObject; y: DWord);
Procedure jViewFlipper_setMarginRight(env:PJNIEnv;this:jobject; ViewFlipper : jObject; x: DWord);
Procedure jViewFlipper_setMarginBottom(env:PJNIEnv;this:jobject; ViewFlipper : jObject; y: DWord);
Procedure jViewFlipper_setLParamWidth(env:PJNIEnv;this:jobject; ViewFlipper : jObject; w: DWord);
Procedure jViewFlipper_setLParamHeight(env:PJNIEnv;this:jobject; ViewFlipper : jObject; h: DWord);
Procedure jViewFlipper_setLParamWidth2(env:PJNIEnv;this:jobject; ViewFlipper : jObject; w: DWord);
Procedure jViewFlipper_setLParamHeight2(env:PJNIEnv;this:jobject; ViewFlipper : jObject; h: DWord);

Procedure jViewFlipper_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jViewFlipper_addLParamsParentRule(env:PJNIEnv;this:jobject; ViewFlipper : jObject; rule: DWord);
Procedure jViewFlipper_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ViewFlipper : jObject; rule: DWord);
Procedure jViewFlipper_setLayoutAll(env:PJNIEnv;this:jobject; ViewFlipper : jObject;  idAnchor: DWord);
Procedure jViewFlipper_setLayoutAll2(env:PJNIEnv;this:jobject; ViewFlipper : jObject;  idAnchor: DWord);

// WebView
Function  jWebView_Create              (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject) : jObject;

//by jmpessoa
Function  jWebView_Create2              (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jWebView_Free                (env:PJNIEnv;this:jobject; WebView : jObject);

Procedure jWebView_Free2                (env:PJNIEnv;this:jobject; WebView : jObject);
//
Procedure jWebView_setXYWH             (env:PJNIEnv;this:jobject;
                                        WebView : jObject;x,y,w,h : integer);
Procedure jWebView_setParent           (env:PJNIEnv;this:jobject;
                                        WebView : jObject;ViewGroup : jObject);

Procedure jWebView_setParent2           (env:PJNIEnv;this:jobject;
                                        WebView : jObject;ViewGroup : jObject);

Procedure jWebView_setJavaScript       (env:PJNIEnv;this:jobject;
                                        WebView : jObject; javascript : boolean);

Procedure jWebView_setJavaScript2       (env:PJNIEnv;this:jobject;
                                        WebView : jObject; javascript : boolean);

Procedure jWebView_loadURL             (env:PJNIEnv;this:jobject;
                                        WebView : jObject; Str : String);
//by jmpessoa
Procedure jWebView_loadURL2(env:PJNIEnv;this:jobject; WebView : jObject; Str : String);

//by jmpessoa
Procedure jWebView_setId(env:PJNIEnv;this:jobject; WebView : jObject; id: DWord);
Procedure jWebView_setMarginLeft(env:PJNIEnv;this:jobject; WebView : jObject; x: DWord);
Procedure jWebView_setMarginTop(env:PJNIEnv;this:jobject; WebView : jObject; y: DWord);
Procedure jWebView_setMarginRight(env:PJNIEnv;this:jobject; WebView : jObject; x: DWord);
Procedure jWebView_setMarginBottom(env:PJNIEnv;this:jobject; WebView : jObject; y: DWord);
Procedure jWebView_setLParamWidth(env:PJNIEnv;this:jobject; WebView : jObject; w: DWord);
Procedure jWebView_setLParamHeight(env:PJNIEnv;this:jobject; WebView : jObject; h: DWord);

Procedure jWebView_setLParamWidth2(env:PJNIEnv;this:jobject; WebView : jObject; w: DWord);
Procedure jWebView_setLParamHeight2(env:PJNIEnv;this:jobject; WebView : jObject; h: DWord);

Procedure jWebView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        WebView: jObject; ml,mt,mr,mb,w,h: integer);

Procedure jWebView_addLParamsParentRule(env:PJNIEnv;this:jobject; WebView : jObject; rule: DWord);
Procedure jWebView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; WebView : jObject; rule: DWord);
Procedure jWebView_setLayoutAll(env:PJNIEnv;this:jobject; WebView : jObject;  idAnchor: DWord);
Procedure jWebView_setLayoutAll2(env:PJNIEnv;this:jobject; WebView : jObject;  idAnchor: DWord);

// Canvas
Function  jCanvas_Create               (env:PJNIEnv;this:jobject;
                                        SelfObj : TObject) : jObject;

Procedure jCanvas_Free                 (env:PJNIEnv;this:jobject; jCanvas : jObject);

Procedure jCanvas_Free2                 (env:PJNIEnv;this:jobject; jCanvas : jObject);
//
Procedure jCanvas_setStrokeWidth       (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject;width : single);
Procedure jCanvas_setStrokeWidth2       (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject;width : single);

Procedure jCanvas_setStyle             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; style : integer);
Procedure jCanvas_setStyle2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; style : integer);

Procedure jCanvas_setColor             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; color : DWord  );
Procedure jCanvas_setColor2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; color : DWord  );

Procedure jCanvas_setTextSize          (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; textsize : single);

Procedure jCanvas_setTextSize2          (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; textsize : single);
Procedure jCanvas_drawLine             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; x1,y1,x2,y2 : single);
Procedure jCanvas_drawLine2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; x1,y1,x2,y2 : single);
// LORDMAN 2013-08-13
Procedure jCanvas_drawPoint            (env:PJNIEnv;this:jobject; jCanvas:jObject; x1,y1:single);

Procedure jCanvas_drawPoint2            (env:PJNIEnv;this:jobject; jCanvas:jObject; x1,y1:single);

Procedure jCanvas_drawText             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; const text : string; x,y : single);

Procedure jCanvas_drawText2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; const text : string; x,y : single);

Procedure jCanvas_drawBitmap           (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; bmp : jObject; b,l,r,t : integer);

Procedure jCanvas_drawBitmap2           (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; bmp : jObject; b,l,r,t : integer); overload;


// Bitmap
Function  jBitmap_Create               (env:PJNIEnv;this:jobject;
                                        SelfObj : TObject) : jObject;

Procedure jBitmap_Free                 (env:PJNIEnv;this:jobject; jbitmap : jObject);

Procedure jBitmap_Free2                 (env:PJNIEnv;this:jobject; jbitmap : jObject);

Procedure jBitmap_loadFile             (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; filename : String);

Procedure jBitmap_loadRes             (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; imgResIdentifier : String);


Procedure jBitmap_loadFile2             (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; filename : String);

Procedure jBitmap_createBitmap         (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; w,h : integer);
Procedure jBitmap_createBitmap2         (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; w,h : integer);

Procedure jBitmap_getWH                (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; var w,h : integer);
//by jmpessoa
Procedure jBitmap_getWH2                (env:PJNIEnv;this:jobject;
                                        jbitmap : jObject; var w,h : integer);

function jBitmap_GetWidth(env: PJNIEnv; this: JObject; _jbitmap: JObject): integer;
function jBitmap_GetHeight(env: PJNIEnv; this: JObject; _jbitmap: JObject): integer;


Function  jBitmap_jInstance(env:PJNIEnv;this:jobject;
                                        jbitmap : jObject) : jObject;
//by jmpessoa
Function  jBitmap_jInstance2(env:PJNIEnv; this:jobject; jbitmap: jObject): jObject;

//by jmpessoa
function jBitmap_GetByteArrayFromBitmap(env:PJNIEnv; this:jobject; jbitmap: jObject;
                                                   var bufferImage: TArrayOfByte): integer;
//by jmpessoa
procedure jBitmap_SetByteArrayToBitmap(env:PJNIEnv; this:jobject; jbitmap: jObject;
                                                                        var bufferImage: TArrayOfByte; size: integer);
//GLSurfaceView
Function  jGLSurfaceView_Create        (env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject; version : integer) : jObject;

//by jmpessoa
Function  jGLSurfaceView_Create2        (env:PJNIEnv; this:jobject; SelfObj: TObject; version: integer): jObject;

Procedure jGLSurfaceView_Free          (env:PJNIEnv;this:jobject; GLSurfaceView : jObject);

Procedure jGLSurfaceView_Free2          (env:PJNIEnv;this:jobject; GLSurfaceView : jObject);
//
Procedure jGLSurfaceView_setXYWH       (env:PJNIEnv;this:jobject;
                                        GLSurfaceView: jObject;x,y,w,h : integer);
Procedure jGLSurfaceView_setParent     (env:PJNIEnv;this:jobject;
                                        GLSurfaceView: jObject;ViewGroup : jObject);

Procedure jGLSurfaceView_setParent2     (env:PJNIEnv;this:jobject;
                                        GLSurfaceView: jObject;ViewGroup : jObject);
                                        
Procedure jGLSurfaceView_SetAutoRefresh(env:PJNIEnv;this:jobject; glView : jObject; Active : Boolean);

//by jmpessoa
Procedure jGLSurfaceView_SetAutoRefresh2(env:PJNIEnv;this:jobject; glView : jObject; Active : Boolean);


Procedure jGLSurfaceView_Refresh       (env:PJNIEnv;this:jobject; glView : jObject);

//by jmpessoa
Procedure jGLSurfaceView_Refresh2       (env:PJNIEnv;this:jobject; glView : jObject);

Procedure jGLSurfaceView_deleteTexture (env:PJNIEnv;this:jobject; glView : jObject; id : Integer);

//by jmpessoa
Procedure jGLSurfaceView_deleteTexture2 (env:PJNIEnv;this:jobject; glView : jObject; id : Integer);

Procedure jGLSurfaceView_getBmpArray   (env:PJNIEnv;this:jobject;filename: String);

Procedure jGLSurfaceView_requestGLThread(env:PJNIEnv;this:jobject; glView : jObject);

//by jmpessoa
Procedure jGLSurfaceView_requestGLThread2(env:PJNIEnv;this:jobject; glView : jObject);

//by jmpessoa
Procedure jGLSurfaceView_setId(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; id: DWord);
Procedure jGLSurfaceView_setMarginLeft(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; x: DWord);
Procedure jGLSurfaceView_setMarginTop(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; y: DWord);
Procedure jGLSurfaceView_setMarginRight(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; x: DWord);
Procedure jGLSurfaceView_setMarginBottom(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; y: DWord);
Procedure jGLSurfaceView_setLParamWidth(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; w: DWord);
Procedure jGLSurfaceView_setLParamHeight(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; h: DWord);

Procedure jGLSurfaceView_setLParamWidth2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; w: DWord);
Procedure jGLSurfaceView_setLParamHeight2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; h: DWord);

function jGLSurfaceView_getLParamHeight(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;
function jGLSurfaceView_getLParamWidth(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;

function jGLSurfaceView_getLParamHeight2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;
function jGLSurfaceView_getLParamWidth2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;

Procedure jGLSurfaceView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        GLSurfaceView : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jGLSurfaceView_addLParamsParentRule(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; rule: DWord);
Procedure jGLSurfaceView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; rule: DWord);
Procedure jGLSurfaceView_setLayoutAll(env:PJNIEnv;this:jobject; GLSurfaceView : jObject;  idAnchor: DWord);
Procedure jGLSurfaceView_setLayoutAll2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject;  idAnchor: DWord);

// Timer
Function  jTimer_Create                (env:PJNIEnv;this:jobject; SelfObj: TObject): jObject;

Procedure jTimer_Free                  (env:PJNIEnv;this:jobject; Timer  : jObject);

Procedure jTimer_Free2                  (env:PJNIEnv;this:jobject; Timer  : jObject);

Procedure jTimer_SetInterval           (env:PJNIEnv;this:jobject; Timer  : jObject; Interval : Integer);

//by jmpessoa
Procedure jTimer_SetInterval2          (env:PJNIEnv;this:jobject; Timer  : jObject; Interval : Integer);

Procedure jTimer_SetEnabled            (env:PJNIEnv;this:jobject; Timer  : jObject; Active   : Boolean);

//by jmpessoa
Procedure jTimer_SetEnabled2            (env:PJNIEnv;this:jobject; Timer  : jObject; Active   : Boolean);

// Dialog YN
Function  jDialogYN_Create             (env:PJNIEnv;this:jobject; SelfObj : TObject;
                                        title,msg,y,n : string ): jObject;
Procedure jDialogYN_Free               (env:PJNIEnv;this:jobject; DialogYN: jObject);

Procedure jDialogYN_Free2               (env:PJNIEnv;this:jobject; DialogYN: jObject);
//
Procedure jDialogYN_Show               (env:PJNIEnv;this:jobject; DialogYN: jObject);

Procedure jDialogYN_Show2               (env:PJNIEnv;this:jobject; DialogYN: jObject);

// Dialog Progress
Function  jDialogProgress_Create       (env:PJNIEnv;this:jobject; SelfObj : TObject;
                                        title,msg : string ): jObject;

Procedure jDialogProgress_Free         (env:PJNIEnv;this:jobject; DialogProgress : jObject);

Procedure jDialogProgress_Free2         (env:PJNIEnv;this:jobject; DialogProgress : jObject);

// Toast
Procedure jToast                       (env:PJNIEnv;this:jobject; Str : String);

// View
Function  jImageBtn_Create(env:PJNIEnv;this:jobject; context: jObject; SelfObj : TObject) : jObject;

//by jmpessoa
Function  jImageBtn_Create2             (env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;

Procedure jImageBtn_Free               (env:PJNIEnv;this:jobject; ImageBtn : jObject);

Procedure jImageBtn_Free2               (env:PJNIEnv;this:jobject; ImageBtn : jObject);

Procedure jImageBtn_setXYWH            (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject;x,y,w,h : integer);
Procedure jImageBtn_setParent          (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject;ViewGroup : jObject);
Procedure jImageBtn_setButton          (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject;up,dn : String);
//by jmpessoa
Procedure jImageBtn_setButtonUp        (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; up: String);
//by jmpessoa
Procedure jImageBtn_setButtonDown       (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; dn: String);

//by jmpessoa
Procedure jImageBtn_setButtonUp2        (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; up: String);

//by jmpessoa
Procedure jImageBtn_setButtonDown2       (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; dn: String);

//by jmpessoa
Procedure jImageBtn_setButtonDownByRes       (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; imgResIdentifief: String);
//by jmpessoa
Procedure jImageBtn_setButtonUpByRes       (env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; imgResIdentifief: String);


Procedure jImageBtn_SetEnabled         (env:PJNIEnv;this:jobject; 
                                        ImageBtn : jObject; Active : Boolean);
//by jmpessoa
Procedure jImageBtn_setId(env:PJNIEnv;this:jobject; ImageBtn : jObject; id: DWord);
Procedure jImageBtn_setMarginLeft(env:PJNIEnv;this:jobject; ImageBtn : jObject; x: DWord);
Procedure jImageBtn_setMarginTop(env:PJNIEnv;this:jobject; ImageBtn : jObject; y: DWord);
Procedure jImageBtn_setMarginRight(env:PJNIEnv;this:jobject; ImageBtn : jObject; x: DWord);
Procedure jImageBtn_setMarginBottom(env:PJNIEnv;this:jobject; ImageBtn : jObject; y: DWord);
Procedure jImageBtn_setLParamWidth(env:PJNIEnv;this:jobject; ImageBtn : jObject; w: DWord);
Procedure jImageBtn_setLParamHeight(env:PJNIEnv;this:jobject; ImageBtn : jObject; h: DWord);
Procedure jImageBtn_setLParamWidth2(env:PJNIEnv;this:jobject; ImageBtn : jObject; w: DWord);
Procedure jImageBtn_setLParamHeight2(env:PJNIEnv;this:jobject; ImageBtn : jObject; h: DWord);

Procedure jImageBtn_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; ml,mt,mr,mb,w,h: integer);

Procedure jImageBtn_addLParamsParentRule(env:PJNIEnv;this:jobject; ImageBtn : jObject; rule: DWord);
Procedure jImageBtn_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ImageBtn : jObject; rule: DWord);
Procedure jImageBtn_setLayoutAll(env:PJNIEnv;this:jobject; ImageBtn : jObject;  idAnchor: DWord);
Procedure jImageBtn_setLayoutAll2(env:PJNIEnv;this:jobject; ImageBtn : jObject;  idAnchor: DWord);

//
Function  jAsyncTask_Create             (env:PJNIEnv;   this:jobject;  SelfObj : TObject): jObject;

function jAsyncTask_Create2             (env: PJNIEnv; this:jobject;   SelfObj: TObject): jObject;

Procedure jAsyncTask_Free              (env:PJNIEnv;this:jobject; AsyncTask : jObject);

Procedure jAsyncTask_Free2              (env:PJNIEnv;this:jobject; AsyncTask : jObject);

Procedure jAsyncTask_Execute           (env:PJNIEnv;this:jobject; AsyncTask : jObject);
//by jmpessoa
Procedure jAsyncTask_Execute2           (env:PJNIEnv;this:jobject; AsyncTask : jObject);

Procedure jAsyncTask_setProgress       (env:PJNIEnv;this:jobject; AsyncTask : jObject; Progress : Integer);
//by jmpessoa
Procedure jAsyncTask_setProgress2       (env:PJNIEnv;this:jobject; AsyncTask : jObject; Progress : Integer);

//by jmpessoa
Procedure jAsyncTask_SetAutoPublishProgress(env:PJNIEnv;this:jobject; AsyncTask : jObject; Value : boolean);

{jSqliteCursor : by jmpessoa}

Function  jSqliteCursor_Create(env:PJNIEnv; this:jobject; SelfObj: TObject): jObject;
Procedure jSqliteCursor_Free(env:PJNIEnv;this:jobject; SqliteCursor: jObject);

procedure jSqliteCursor_SetCursor(env:PJNIEnv; this:jobject; SqliteCursor: jObject; Cursor: jObject);

Function  jSqliteCursor_GetCursor(env:PJNIEnv; this:jobject; SqliteCursor: jObject): jObject;

procedure jSqliteCursor_MoveToFirst(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
procedure jSqliteCursor_MoveToNext(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
procedure jSqliteCursor_MoveToLast(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
procedure jSqliteCursor_MoveToPosition(env:PJNIEnv; this:jobject; SqliteCursor: jObject; position: integer);

Function jSqliteCursor_GetRowCount(env:PJNIEnv; this:jobject; SqliteCursor: jObject): integer;

Function jSqliteCursor_GetColumnCount(env:PJNIEnv; this:jobject; SqliteCursor: jObject):  integer;
Function jSqliteCursor_GetColumnIndex(env:PJNIEnv; this:jobject; SqliteCursor: jObject; colName: string): integer;
Function jSqliteCursor_GetColumName(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): string;

Function jSqliteCursor_GetColType(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): integer;

Function jSqliteCursor_GetValueAsString(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): string;
function jSqliteCursor_GetValueAsBitmap(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): jObject;

function jSqliteCursor_GetValueAsDouble (env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): double;
function jSqliteCursor_GetValueAsFloat (env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): real;

function jSqliteCursor_GetValueAsInteger(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): integer;
{jSqliteDataAccess: by jmpessoa}

Function  jSqliteDataAccess_Create(env: PJNIEnv; this:jobject;  SelfObj: TObject;
                                        dataBaseName: string; colDelimiter: char; rowDelimiter: char): jObject;

Procedure jSqliteDataAccess_Free(env:PJNIEnv;this:jobject; SqliteDataBase : jObject);

function jSqliteDataAccess_CheckDataBaseExists(env:PJNIEnv; this:jobject; SqliteDataBase: jObject; fullPathDB: string): boolean;
Procedure jSqliteDataAccess_ExecSQL(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; execQuery: string);

Procedure jSqliteDataAccess_OpenOrCreate(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; dataBaseName: string);
Procedure jSqliteDataAccess_AddTableName(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; tableName: string);

Procedure jSqliteDataAccess_AddCreateTableQuery(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; createTableQuery: string);

procedure jSqliteDataAccess_CreateAllTables(env:PJNIEnv;this:jobject; SqliteDataBase: jObject);
procedure jSqliteDataAccess_DropAllTables(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; recreate: boolean);

function jSqliteDataAccess_Select(env:PJNIEnv; this:jobject; SqliteDataBase:jObject; selectQuery: string): string; overload;
procedure jSqliteDataAccess_Select(env:PJNIEnv; this:jobject; SqliteDataBase: jObject; selectQuery: string); overload;

function jSqliteDataAccess_GetCursor(env:PJNIEnv; this:jobject; SqliteDataBase: jObject): jObject;

procedure jSqliteDataAccess_SetSelectDelimiters(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; coldelim: char; rowdelim: char);
procedure jSqliteDataAccess_CreateTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; createQuery: string);
procedure jSqliteDataAccess_DropTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; tableName: string);
procedure jSqliteDataAccess_InsertIntoTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; insertQuery: string);

procedure jSqliteDataAccess_DeleteFromTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; deleteQuery: string);

procedure jSqliteDataAccess_UpdateTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; updateQuery: string);
procedure jSqliteDataAccess_UpdateImage(env:PJNIEnv;this:jobject; SqliteDataBase: jObject;
                                        tableName: string; imageFieldName: string; keyFieldName: string; imageValue: jObject; keyValue: integer); overload;

procedure jSqliteDataAccess_Close(env:PJNIEnv;this:jobject; SqliteDataBase: jObject);

procedure jSqliteDataAccess_SetForeignKeyConstraintsEnabled(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _value: boolean);
procedure jSqliteDataAccess_SetDefaultLocale(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject);
procedure jSqliteDataAccess_DeleteDatabase(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _dbName: string);
procedure jSqliteDataAccess_UpdateImage(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _tabName: string; _imageFieldName: string; _keyFieldName: string; _imageResIdentifier: string; _keyValue: integer); overload;
procedure jSqliteDataAccess_InsertIntoTableBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _insertQueries: TDynArrayOfString);
procedure jSqliteDataAccess_UpdateTableBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _updateQueries: TDynArrayOfString);
function jSqliteDataAccess_CheckDataBaseExistsByName(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _dbName: string): boolean;

procedure jSqliteDataAccess_UpdateImageBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _imageResIdentifierDataArray: TDynArrayOfString; _delimiter: string);


// Http
Function  jHttp_Get(env:PJNIEnv; this:jobject; URL: String) : String;

//by jmpessoa
procedure jSend_Email(env:PJNIEnv; this:jobject;
                       sto: string;
                       scc: string;
                       sbcc: string;
                       ssubject: string;
                       smessage:string);
//by jmpessoa
function jSend_SMS(env:PJNIEnv;this:jobject;
                       toNumber: string;
                       smessage:string): integer;

//by jmpessoa
function jContact_getMobileNumberByDisplayName(env:PJNIEnv;this:jobject;
                                               contactName: string): string;
//by jmpessoa
function jContact_getDisplayNameList(env:PJNIEnv; this:jobject; delimiter: char): string;

// Camera
Procedure jTakePhoto(env:PJNIEnv; this:jobject; filename : String);

//by jmpessoa
function jCamera_takePhoto(env:PJNIEnv; this:jobject;  path: string;  filename : String): string;

// BenchMark
Procedure jBenchMark1_Java             (env:PJNIEnv;this:jobject;var mSec : Integer;var value : single);
Procedure jBenchMark1_Pascal           (env:PJNIEnv;this:jobject;var mSec : Integer;var value : single);

//function Get_gjClass(env: PJNIEnv): jClass; //by jmpessoa
//function JBool( Bool : Boolean ) : byte;

{
Var
  gVM         : PJavaVM;
  gjClass     : jClass = nil;
  gDbgMode    : Boolean;
  gjAppName   : PChar; // Ex 'com.kredix';
  gjClassName : PChar; // Ex 'com/kredix/Controls';
 }

implementation

(* {commented by jmpessoa}
const
 NDKLibLog        = 'liblog.so'; // NDK Log
 ANDROID_LOG_INFO = 4;

function __android_log_write(prio:longint;tag,text:pchar):longint; cdecl; external NDKLibLog; 

procedure dbg(str : String); overload;
 begin
  If Not(gDbgMode) then Exit;
   __android_log_write(ANDROID_LOG_INFO,'JNI_Pascal',Pchar(str));
 end;

procedure dbg(obj : jObject; objName : String); overload;
 begin
  If Not(gDbgMode) then Exit;
  If obj = nil then dbg(objName + ' nil')
               else dbg(objName + ' not nil');
 end;
  *)

//just dummies .... by jmpessoa
procedure dbg(str : String); overload;
begin
  //If Not(gDbgMode) then Exit;
  // __android_log_write(ANDROID_LOG_INFO,'JNI_Pascal',Pchar(str));
end;

procedure dbg(obj : jObject; objName : String); overload;
 begin
  If Not(gDbgMode) then Exit;
  If obj = nil then dbg(objName + ' nil')
               else dbg(objName + ' not nil');
 end;

function JBool( Bool : Boolean ) : byte;
 begin
  Case Bool of
   True  : Result := 1;
   False : Result := 0;
  End;
 end;


//------------------------------------------------------------------------------
// JNI_OnLoad, Unload
//------------------------------------------------------------------------------

//
(*  {commented by jmpessoa}
function JNI_OnLoad(vm:PJavaVM;reserved:pointer):jint; cdecl;
 begin
  dbg('JNI_OnLoad called');
  gVM := vm;
  result:=JNI_VERSION_1_6;
 end;

procedure JNI_OnUnload(vm:PJavaVM;reserved:pointer); cdecl;
 begin
  dbg('JNI_OnUnload called');
 end;

 *)

//------------------------------------------------------------------------------
// Base Conversion
//------------------------------------------------------------------------------

//by jmpessoa: try fix this BUG....

// ref. http://android-developers.blogspot.cz/2011/11/jni-local-reference-changes-in-ics.html

// http://stackoverflow.com/questions/14765776/jni-error-app-bug-accessed-stale-local-reference-0xbc00021-index-8-in-a-tabl


Procedure jClassMethod(FuncName, FuncSig : PChar;
                       env : PJNIEnv; var Class_ : jClass; var Method_ :jMethodID);
var
  tmpClass: jClass;
begin
  if Class_  = nil then
  begin
    //by jmpessoa fix: "FindClass" returns only  local references..."
    tmpClass:= jClass(env^.FindClass(env, gjClassName));
    if tmpClass <> nil then
    begin
       Class_ := env^.NewGlobalRef(env, tmpClass);  //<< -------- jmpessoa fix!
    end;
  end;
  if Method_ = nil then
  begin       //a jmethodID is not an object. So don't need to convert it to a GlobalRef!
    Method_:= env^.GetMethodID( env, Class_ , FuncName, FuncSig);
  end;
end;

//----------------------------------------------------------------

(*
// LORDMAN - 2013-07-28
Function jStr_getLength (env:PJNIEnv; this:jobject; Str : String): Integer;
 Const
  _cFuncName = 'getStrLength';
  _cFuncSig  = '(Ljava/lang/String;)I';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig, env, gjClass, _jMethod);
  _jParams.l := env^.NewStringUTF(env, pchar(Str) );
  Result     := env^.CallIntMethodA(env, this ,_jMethod,@_jParams);
 end;
*)

// LORDMAN - 2013-07-30 //
(*
Function  jStr_GetDateTime(env:PJNIEnv; this:jobject): String;  //return Controls "version-revision"!
 Const
  _cFuncName = 'getStrDateTime';
  _cFuncSig  = '()Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jString  := env^.CallObjectMethod(env,this,_jMethod);
  case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
          end;
  end;
 end;
*)


//
Function  jgetTick (env:PJNIEnv;this:jobject) : LongInt;
Const
 _cFuncName = 'getTick';
 _cFuncSig  = '()J';
Var
 _jMethod : jMethodID = nil;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 Result     := env^.CallLongMethod(env,this,_jMethod);
end;

//------------------------------------------------------------------------------
// View
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// System
//------------------------------------------------------------------------------

// Garbage Collection
Procedure jSystem_GC(env:PJNIEnv;this:jobject);
const
  _cFuncName = 'systemGC';
  _cFuncSig  = '()V';
var
  _jMethod : jMethodID = nil;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  env^.CallVoidMethod(env,this,_jMethod);
end;

//by jmpessoa
Procedure jSystem_GC2(env:PJNIEnv; this:jobject);
var
  cls: jClass;
  method: jmethodID;
begin
  cls := env^.GetObjectClass(env, this);
  method:= env^.GetMethodID(env, cls, 'systemGC', '()V');
  env^.CallVoidMethod(env, this, method);
end;


//------------------------------------------------------------------------------
// Class
//------------------------------------------------------------------------------

Procedure jClass_setNull(env:PJNIEnv;this:jobject; ClassObj : jClass);
Const
 _cFuncName = 'classSetNull';
 _cFuncSig  = '(Ljava/lang/Class;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l := ClassObj;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
end;

Procedure jClass_chkNull(env:PJNIEnv;this:jobject; ClassObj : jObject);
Const
 _cFuncName = 'classChkNull';
 _cFuncSig  = '(Ljava/lang/Class;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l := ClassObj;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
end;

//------------------------------------------------------------------------------
// App
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Asset
//------------------------------------------------------------------------------

//  src     'test.txt'
//  outFile '/data/data/com/kredix/files/test.txt'
//            App.Path.Dat+'/image01.png'
Function  jAsset_SaveToFile(env:PJNIEnv; this:jobject; src,dst:String) : Boolean;
 Const
  _cFuncName = 'assetSaveToFile';
  _cFuncSig  = '(Ljava/lang/String;Ljava/lang/String;)Z';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
 // _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := env^.NewStringUTF(env, pchar(src) );
  _jParams[1].l := env^.NewStringUTF(env, pchar(dst) );
  _jBoolean  := env^.CallBooleanMethodA(env,this,_jMethod,@_jParams);
  Result     := Boolean(_jBoolean);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;


//------------------------------------------------------------------------------
// Image Info
//------------------------------------------------------------------------------

Function  jImage_getWH                 (env:PJNIEnv;this:jobject; filename : String ) : TWH;
 Const
  _cFuncName = 'Image_getWH';
  _cFuncSig  = '(Ljava/lang/String;)I';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
  _wh      : Integer;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l  := env^.NewStringUTF(env, pchar(filename) );
  _wh        := env^.CallIntMethodA(env,this,_jMethod,@_jParam);
  env^.DeleteLocalRef(env,_jParam.l);
  //
  Result.Width  := (_wh shr 16);
  Result.Height := (_wh and $0000FFFF);
  dbg('Image : ' + IntToStr(Result.Width) + 'x' + IntTostr(Result.Height));
 end;

//
Function  jImage_resample              (env:PJNIEnv;this:jobject; filename : String; size : integer ) : jObject;
 Const
  _cFuncName = 'Image_resample';
  _cFuncSig  = '(Ljava/lang/String;I)Landroid/graphics/Bitmap;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
  _jObject : jObject;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := env^.NewStringUTF(env, pchar(filename) );
  _jParams[1].i := size;
  _jObject      := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  Result := _jObject;
  dbg('resampling');
 end;

Procedure jImage_save                  (env:PJNIEnv;this:jobject; Bitmap : jObject; filename : String);
 Const
  _cFuncName = 'Image_save';
  _cFuncSig  = '(Landroid/graphics/Bitmap;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
 // _jObject : jObject;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Bitmap;;
  _jParams[1].l := env^.NewStringUTF(env, pchar(filename) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

//------------------------------------------------------------------------------
// TextView
//------------------------------------------------------------------------------

//
Function jTextView_Create(env:PJNIEnv;this:jobject;
                          context : jObject; SelfObj : TObject ) : jObject;
 Const
  _cFuncName = 'jTextView_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;


//by jmpessoa


Function jTextView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jTextView_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jTextView_Free(env:PJNIEnv;this:jobject; TextView : jObject);
Const
 _cFuncName = 'jTextView_Free';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := TextView;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteGlobalRef(env,TextView);
end;

Procedure jTextView_Free2(env:PJNIEnv;this:jobject; TextView : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, TextView);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,TextView,_jMethod);
 env^.DeleteGlobalRef(env,TextView);
end;

//
Procedure jTextView_setEnabled (env:PJNIEnv;this:jobject;
                                TextView : jObject; enabled : Boolean);
Const
 _cFuncName = 'jTextView_setEnabled';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].z := JBool(enabled);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_SetVisible(env:PJNIEnv;this:jobject; TextView : jObject; visible : Boolean);
var
   cls: jClass;
   method: jmethodID;
   _jParams : array[0..0] of jValue;
begin
    case visible of
     True  : _jParams[0].i := 0; //
     False : _jParams[0].i := 4; //
    end;
    cls := env^.GetObjectClass(env, TextView);
    method:= env^.GetMethodID(env, cls, 'setVisibility', '(I)V');
    env^.CallVoidMethodA(env, TextView, method, @_jParams);
end;

// 
Procedure jTextView_setXYWH(env:PJNIEnv;this:jobject;
                            TextView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jTextView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jTextView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        TextView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jTextView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//        jTextView_setParent
Procedure jTextView_setParent(env:PJNIEnv;this:jobject;
                              TextView: jObject; ViewGroup: jObject);
 Const
  _cFuncName = 'jTextView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jTextView_setParent2(env:PJNIEnv;this:jobject;
                              TextView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jTextView_setParent2';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

//by jmpessoa
Procedure jTextView_setParent3(env:PJNIEnv;this:jobject;
                              TextView : jObject;ViewGroup : jObject);
 var
    cls: jClass;
    method: jmethodID;
    _jParams : array[0..0] of jValue;
 begin
     _jParams[0].l := ViewGroup;
     cls := env^.GetObjectClass(env, TextView);
     method:= env^.GetMethodID(env, cls, 'setParent3', '(Landroid/view/ViewGroup;)V');
     env^.CallVoidMethodA(env, TextView, method, @_jParams);
 end;
//

// Java Function
Function jTextView_getText(env:PJNIEnv;this:jobject; TextView : jObject) : String;
 Const
  _cFuncName = 'jTextView_getText';
  _cFuncSig  = '(Ljava/lang/Object;)Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := TextView;
  _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
 end;

Function jTextView_getText2(env:PJNIEnv;this:jobject; TextView : jObject) : String;
var
  _jMethod : jMethodID = nil;
  _jString : jString;
  _jBoolean: jBoolean;
  cls: jClass;
begin

  cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'getText2', '()Ljava/lang/String;');

  _jString   := env^.CallObjectMethod(env,TextView,_jMethod);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
          end;
  end;
end;

// Java Function
Procedure jTextView_setText(env:PJNIEnv;this:jobject;
                            TextView : jObject; Str : String);
 Const
  _cFuncName = 'jTextView_setText';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

//by jmpessoa
Procedure jTextView_setText2(env: PJNIEnv; this:jobject;
                            TextView : jObject; Str : String);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str));
  cls := env^.GetObjectClass(env, TextView);
  method:= env^.GetMethodID(env, cls, 'setText2', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, TextView, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;
//

Procedure jTextView_setTextColor(env:PJNIEnv;this:jobject;
                                  TextView : jObject; color : DWord);
Const
  _cFuncName = 'jTextView_setTextColor';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].i := color;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


Procedure jTextView_setTextColor2(env:PJNIEnv;this:jobject;
                                  TextView : jObject; color : DWord);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := color;
  cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(I)V');
  env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

// Font Height ( Pixel )
Procedure jTextView_setTextSize (env:PJNIEnv;this:jobject;
                                  TextView : jObject; size : DWord);
 Const
  _cFuncName = 'jTextView_setTextSize';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := TextView;
  _jParams[1].i := size;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jTextView_setTextSize2 (env:PJNIEnv;this:jobject;
                                  TextView : jObject; size : DWord);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := size;
  cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setTextSize2', '(I)V');
  env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

Procedure jTextView_SetTextTypeFace(env:PJNIEnv;this:jobject; TextView : jObject; value  : DWord);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := value;
  cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'SetTextTypeFace', '(I)V');
  env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

// LORDMAN - 2013-08-12
Procedure jTextView_setTextAlignment(env:PJNIEnv;this:jobject; TextView : jObject; align : DWord);
Const
 _cFuncName = 'jTextView_setTextAlignment';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := align;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_addLParamsParentRule(env:PJNIEnv;this:jobject; TextView : jObject; rule: DWord);
Const
 _cFuncName = 'jTextView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; TextView : jObject; rule: DWord);
Const
 _cFuncName = 'jTextView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setLayoutAll(env:PJNIEnv;this:jobject; TextView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jTextView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jTextView_setLayoutAll2(env:PJNIEnv;this:jobject; TextView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setLParamWidth(env:PJNIEnv;this:jobject; TextView : jObject; w: DWord);
Const
 _cFuncName = 'jTextView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jTextView_setLParamWidth2(env:PJNIEnv;this:jobject; TextView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setLParamHeight(env:PJNIEnv;this:jobject; TextView : jObject; h: DWord);
Const
 _cFuncName = 'jTextView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jTextView_setLParamHeight2(env:PJNIEnv;this:jobject; TextView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
 cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setId(env:PJNIEnv;this:jobject; TextView : jObject; id: DWord);
Const
 _cFuncName = 'jTextView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jTextView_setId2(env:PJNIEnv;this:jobject; TextView : jObject; id: DWord);
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := id;
  cls := env^.GetObjectClass(env, TextView);
  _jMethod:= env^.GetMethodID(env, cls, 'setIdEx', '(I)V');
 env^.CallVoidMethodA(env,TextView,_jMethod,@_jParams);
end;

Procedure jTextView_setMarginLeft(env:PJNIEnv;this:jobject; TextView : jObject; x: DWord);
Const
 _cFuncName = 'jTextView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setMarginTop(env:PJNIEnv;this:jobject; TextView : jObject; y: DWord);
Const
 _cFuncName = 'jTextView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jTextView_setMarginRight(env:PJNIEnv;this:jobject; TextView : jObject; x: DWord);
Const
 _cFuncName = 'jTextView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jTextView_setMarginBottom(env:PJNIEnv;this:jobject; TextView : jObject; y: DWord);
Const
 _cFuncName = 'jTextView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := TextView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// EditText
//------------------------------------------------------------------------------

//
Function jEditText_Create(env:PJNIEnv;this:jobject;
                          context : jObject; SelfObj : TObject ) : jObject;
 Const
  _cFuncName = 'jEditText_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
Function jEditText_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env);{global}           {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jEditText_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;


//
Procedure jEditText_Free (env:PJNIEnv;this:jobject; EditText : jObject);
  Const
   _cFuncName = 'jEditText_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := EditText;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,EditText);
  end;

//by jmpessoa
Procedure jEditText_Free2(env:PJNIEnv;this:jobject; EditText : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
   cls := env^.GetObjectClass(env, EditText);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,EditText,_jMethod);
   env^.DeleteGlobalRef(env,EditText);
end;

//
Procedure jEditText_setXYWH(env:PJNIEnv;this:jobject;
                            EditText : jObject; x,y,w,h: integer);
 Const
  _cFuncName = 'jEditText_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := EditText;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jEditText_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        EditText : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jEditText_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jEditText_setParent(env:PJNIEnv;this:jobject;
                              EditText : jObject;ViewGroup : jObject);
const
  _cFuncName = 'jEditText_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := EditText;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setParent2(env:PJNIEnv;this:jobject;
                              EditText : jObject;ViewGroup : jObject);
 var
    cls: jClass;
    method: jmethodID;
    _jParams : array[0..0] of jValue;
 begin
     _jParams[0].l := ViewGroup;
     cls := env^.GetObjectClass(env, EditText);
     method:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
     env^.CallVoidMethodA(env, EditText, method, @_jParams);
 end;
//

// Java Function
Function jEditText_getText(env:PJNIEnv;this:jobject; EditText : jObject) : String;
 Const
  _cFuncName = 'jEditText_getText';
  _cFuncSig  = '(Ljava/lang/Object;)Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := EditText;
  _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
 end;

//by jmpessoa
Function jEditText_getText2(env:PJNIEnv;this:jobject; EditText : jObject) : String;
var
  _jMethod : jMethodID = nil;
  _jString : jString;
  _jBoolean: jBoolean;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, EditText);
  _jMethod:= env^.GetMethodID(env, cls, 'getTextEx', '()Ljava/lang/String;');
  _jString   := env^.CallObjectMethod(env,EditText,_jMethod);
  case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
          end;
  end;
end;

// Java Function
Procedure jEditText_setText(env:PJNIEnv;this:jobject;
                            EditText : jObject; Str : String);
 Const
  _cFuncName = 'jEditText_setText';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := EditText;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

Procedure jEditText_setText2(env:PJNIEnv; this:jobject; EditText: jObject; Str: String);
var
  _jParams : array[0..0] of jValue;
   cls: jClass;
   method: jmethodID;
begin
  _jParams[0].l:= env^.NewStringUTF(env, PChar(Str));
  cls := env^.GetObjectClass(env, EditText);
  method:= env^.GetMethodID(env, cls, PChar('setTextEx'), PChar('(Ljava/lang/String;)V'));
  env^.CallVoidMethodA(env, EditText,method, @_jParams);
  env^.DeleteLocalRef(env, _jParams[0].l);
end;

//
Procedure jEditText_setTextColor (env:PJNIEnv;this:jobject;
                                  EditText : jObject; color : DWord);
Const
 _cFuncName = 'jEditText_setTextColor';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := color;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setTextColor2 (env:PJNIEnv;this:jobject;
                                  EditText : jObject; color : DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := color;
 cls := env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(I)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

// Font Height ( Pixel )
Procedure jEditText_setTextSize(env:PJNIEnv;this:jobject;
                                 EditText : jObject; size : DWord);
Const
 _cFuncName = 'jEditText_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jEditText_setTextSize2(env:PJNIEnv;this:jobject;
                                 EditText : jObject; size : DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := size;
 cls := env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextSize2', '(I)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

// Hint, PlaceHolder
Procedure jEditText_setHint(env:PJNIEnv;this:jobject; EditText : jObject;
                                 Str : String);
Const
 _cFuncName = 'jEditText_setHint';
 _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

Procedure jEditText_setHint2(env:PJNIEnv;this:jobject; EditText : jObject;
                                 Str : String);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
 cls := env^.GetObjectClass(env, EditText);
_jMethod:= env^.GetMethodID(env, cls, 'setHint2', '(Ljava/lang/String;)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;


// LORDMAN - 2013-07-26
Procedure jEditText_SetFocus(env:PJNIEnv;this:jobject; EditText : jObject );
Const
 _cFuncName = 'jEditText_SetFocus';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_SetFocus2(env:PJNIEnv;this:jobject; EditText : jObject );
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, EditText);
  _jMethod:= env^.GetMethodID(env, cls, 'setFocus2', '()V');
 env^.CallVoidMethod(env,EditText,_jMethod);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_immShow(env:PJNIEnv;this:jobject; EditText : jObject );
Const
 _cFuncName = 'jEditText_immShow';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_immShow2(env:PJNIEnv;this:jobject; EditText : jObject );
Var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, EditText);
  _jMethod:= env^.GetMethodID(env, cls, 'immShow2', '()V');
 env^.CallVoidMethod(env,EditText,_jMethod);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_immHide(env:PJNIEnv;this:jobject; EditText : jObject );
Const
 _cFuncName = 'jEditText_immHide';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod, @_jParams);
end;

Procedure jEditText_immHide2(env:PJNIEnv;this:jobject; EditText : jObject );
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, EditText);
  _jMethod:= env^.GetMethodID(env, cls, 'immHide2', '()V');
 env^.CallVoidMethod(env,EditText,_jMethod);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_editInputType(env:PJNIEnv;this:jobject; EditText : jObject; Str : String);
const
 _cFuncName = 'jEditText_InputType';
 _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

//by jmpessoa
Procedure jEditText_editInputType2(env:PJNIEnv;this:jobject; EditText : jObject; Str : String);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
 cls:= env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'setInputTypeEx', '(Ljava/lang/String;)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;

//by jmpessoa
Procedure jEditText_editInputTypeEx(env:PJNIEnv; this:jobject; EditText: jObject; itType: DWord);
Const
 _cFuncName = 'jEditText_InputTypeEx';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env, gjClass, _jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := itType;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_editInputTypeEx2(env:PJNIEnv; this:jobject; EditText: jObject; itType: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := itType;
  cls:= env^.GetObjectClass(env, EditText);
  _jMethod:= env^.GetMethodID(env, cls, 'setInputTypeEx', '(I)V');
  env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_maxLength(env:PJNIEnv;this:jobject; EditText : jObject; size  : DWord);
Const
 _cFuncName = 'jEditText_maxLength';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
//The attribute maxLines corresponds to the maximum height of the EditText,
//it controls the outer boundaries and not inner text lines.
Procedure jEditText_setMaxLines(env: PJNIEnv; this: jobject; EditText: jObject; max:DWord);
Const
 _cFuncName = 'jEditText_setMaxLines';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := max;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setSingleLine(env:PJNIEnv;this:jobject; EditText : jObject; isSingle: boolean);
Const
 _cFuncName = 'jEditText_setSingleLine';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig, env, gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(isSingle);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setSingleLine2(env:PJNIEnv;this:jobject; EditText : jObject; isSingle: boolean);
var
 _jMethod: jMethodID = nil;
 _jParams: array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].z:= JBool(isSingle);
  cls:= env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'setSingleLineEx', '(Z)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setHorizontallyScrolling(env:PJNIEnv;this:jobject; EditText : jObject; wrapping: boolean);
Const
 _cFuncName = 'jEditText_setHorizontallyScrolling';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(wrapping);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_addLParamsParentRule(env:PJNIEnv;this:jobject; EditText : jObject; rule: DWord);
Const
 _cFuncName = 'jEditText_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_addLParamsAnchorRule(env:PJNIEnv;this:jobject; EditText : jObject; rule: DWord);
Const
 _cFuncName = 'jEditText_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setLayoutAll(env:PJNIEnv;this:jobject; EditText : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jEditText_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setLayoutAll2(env:PJNIEnv;this:jobject; EditText : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, EditText);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setLParamWidth(env:PJNIEnv;this:jobject; EditText : jObject; w: DWord);
Const
 _cFuncName = 'jEditText_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setLParamWidth2(env:PJNIEnv;this:jobject; EditText : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
  cls := env^.GetObjectClass(env, EditText);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setLParamHeight(env:PJNIEnv;this:jobject; EditText : jObject; h: DWord);
Const
 _cFuncName = 'jEditText_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setLParamHeight2(env:PJNIEnv;this:jobject; EditText : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, EditText);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

Procedure jEditText_setId(env:PJNIEnv;this:jobject; EditText : jObject; id: DWord);
Const
 _cFuncName = 'jEditText_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setMarginLeft(env:PJNIEnv;this:jobject; EditText : jObject; x: DWord);
Const
 _cFuncName = 'jEditText_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setMarginTop(env:PJNIEnv;this:jobject; EditText : jObject; y: DWord);
Const
 _cFuncName = 'jEditText_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setMarginRight(env:PJNIEnv;this:jobject; EditText : jObject; x: DWord);
Const
 _cFuncName = 'jEditText_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setMarginBottom(env:PJNIEnv;this:jobject; EditText : jObject; y: DWord);
Const
 _cFuncName = 'jEditText_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setVerticalScrollBarEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);
Const
 _cFuncName = 'jEditText_setVerticalScrollBarEnabled';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(value);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setHorizontalScrollBarEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);
Const
 _cFuncName = 'jEditText_setHorizontalScrollBarEnabled';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(value);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jEditText_setScrollbarFadingEnabled(env:PJNIEnv;this:jobject; EditText : jObject; value  : boolean);
Const
 _cFuncName = 'jEditText_setHorizontalScrollBarEnabled';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(value);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setScrollBarStyle(env:PJNIEnv;this:jobject; EditText : jObject; style  : DWord);
Const
 _cFuncName = 'jEditText_setScrollBarStyle';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := style;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jEditText_setMovementMethod(env:PJNIEnv;this:jobject; EditText : jObject);
Const
 _cFuncName = 'jEditText_setMovementMethod';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_setScroller(env:PJNIEnv; this:jobject; context : jObject; EditText : jObject);
Const
 _cFuncName = 'jEditText_setScroller';
 _cFuncSig  = '(Landroid/content/Context;Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := context;
 _jParams[1].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jEditText_setScroller2(env:PJNIEnv; this:jobject; EditText : jObject);
Const
 _cFuncName = 'jEditText_setScroller2';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_GetCursorPos       (env:PJNIEnv;this:jobject; EditText : jObject; Var x,y : Integer);
Const
 _cFuncName = 'jEditText_GetCursorPos';
 _cFuncSig  = '(Ljava/lang/Object;)[I';
Var
 _jMethod   : jMethodID = nil;
 _jParam    : jValue;
 _jIntArray : jintArray;
 _jBoolean  : jBoolean;
 //
 PInt    : PInteger;
 PIntSav : PInteger;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l  := EditText;
 _jIntArray := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 //
 _jBoolean  := JNI_False;
 PInt       := env^.GetIntArrayElements(env,_jIntArray,_jBoolean);
 PIntSav    := PInt;
 x := PInt^; Inc(PInt);
 y := PInt^; Inc(PInt);
 env^.ReleaseIntArrayElements(env,_jIntArray,PIntSav,0);
end;

Procedure jEditText_GetCursorPos2(env:PJNIEnv;this:jobject; EditText : jObject; Var x,y : Integer);
var
 _jMethod   : jMethodID = nil;
 _jIntArray : jintArray;
 _jBoolean  : jBoolean;
 //
 PInt    : PInteger;
 PIntSav : PInteger;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'getCursorPos', '()[I');
 _jIntArray := env^.CallObjectMethod(env,EditText,_jMethod);
 //
 _jBoolean  := JNI_False;
 PInt       := env^.GetIntArrayElements(env,_jIntArray,_jBoolean);
 PIntSav    := PInt;
 x := PInt^; Inc(PInt);
 y := PInt^; Inc(PInt);
 env^.ReleaseIntArrayElements(env,_jIntArray,PIntSav,0);
end;

// LORDMAN - 2013-07-26
Procedure jEditText_SetCursorPos(env:PJNIEnv;this:jobject; EditText : jObject; startPos,endPos : Integer);
Const
 _cFuncName = 'jEditText_SetCursorPos';
 _cFuncSig  = '(Ljava/lang/Object;II)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..2] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := startPos;
 _jParams[2].i := endPos;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jEditText_SetCursorPos2(env:PJNIEnv;this:jobject; EditText : jObject; startPos,endPos : Integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 cls: jClass;
begin
 _jParams[0].i := startPos;
 _jParams[1].i := endPos;
 cls := env^.GetObjectClass(env, EditText);
 _jMethod:= env^.GetMethodID(env, cls, 'setCursorPos', '(II)V');
 env^.CallVoidMethodA(env,EditText,_jMethod,@_jParams);
end;

// LORDMAN - 2013-08-12
Procedure jEditText_setTextAlignment (env:PJNIEnv;this:jobject; EditText : jObject; align : DWord);
Const
 _cFuncName = 'jEditText_setTextAlignment';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].i := align;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

// LORDMAN 2013-08-27
Procedure jEditText_SetEnabled (env:PJNIEnv;this:jobject;
                                EditText : jObject; enabled : Boolean);
Const
 _cFuncName = 'jEditText_setEnabled';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(enabled);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

// LORDMAN 2013-08-27
Procedure jEditText_SetEditable (env:PJNIEnv;this:jobject;
                                 EditText : jObject; enabled : Boolean);
Const
 _cFuncName = 'jEditText_setEditable';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := EditText;
 _jParams[1].z := JBool(enabled);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// Button
//------------------------------------------------------------------------------

//
Function jButton_Create(env:PJNIEnv;this:jobject;
                        context : jObject; SelfObj: TObject) : jObject;
 Const
  _cFuncName = 'jButton_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env, Result);
 end;

//by jmpessoa
Function jButton_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jButton_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jButton_Free (env:PJNIEnv;this:jobject; Button : jObject);
  Const
   _cFuncName = 'jButton_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   Dbg('jButton_Free #1');
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := Button;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,Button);
  end;

//by jmpessoa
Procedure jButton_Free2(env:PJNIEnv;this:jobject; Button : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
   cls:= env^.GetObjectClass(env, Button);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env, Button, _jMethod);
   env^.DeleteGlobalRef(env, Button);
end;

//
Procedure jButton_setXYWH(env:PJNIEnv;this:jobject;
                          Button : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jButton_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Button;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jButton_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        Button : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jButton_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//
Procedure jButton_setParent(env:PJNIEnv;this:jobject;
                            Button : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jButton_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Button;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jButton_setParent2(env:PJNIEnv;this:jobject;
                            Button : jObject;ViewGroup : jObject);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].l := ViewGroup;
  cls := env^.GetObjectClass(env, Button);
  _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,Button,_jMethod,@_jParams);
end;

//
Procedure jButton_setText(env:PJNIEnv;this:jobject;
                          Button : jObject; Str : String);
 Const
  _cFuncName = 'jButton_setText';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Button;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );

  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

//by jmpessoa
Procedure jButton_setText2(env:PJNIEnv;this:jobject;
                          Button : jObject; Str : String);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  cls := env^.GetObjectClass(env, Button);
  _jMethod:= env^.GetMethodID(env, cls, 'setTextEx', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, Button,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

//
Function jButton_getText(env:PJNIEnv;this:jobject;
                         Button : jObject) : String;
 Const
  _cFuncName = 'jButton_getText';
  _cFuncSig  = '(Ljava/lang/Object;)Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := Button;
  _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
 end;

//
Procedure jButton_setTextColor (env:PJNIEnv;this:jobject;
                                Button : jObject; color : DWord);
Const
 _cFuncName = 'jButton_setTextColor';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := color;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setTextColor2(env:PJNIEnv;this:jobject;
                                Button : jObject; color : DWord);
var
    _jMethod : jMethodID = nil;
    _jParams : array[0..0] of jValue;
    cls: jClass;
begin
    _jParams[0].i := color;
    cls := env^.GetObjectClass(env, Button);
    _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(I)V');
    env^.CallVoidMethodA(env,Button,_jMethod,@_jParams);
end;

// Font Height ( Pixel )
Procedure jButton_setTextSize (env:PJNIEnv;this:jobject;
                               Button : jObject; size : DWord);
Const
 _cFuncName = 'jButton_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_addLParamsParentRule(env:PJNIEnv;this:jobject; Button : jObject; rule: DWord);
Const
 _cFuncName = 'jButton_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_addLParamsAnchorRule(env:PJNIEnv;this:jobject; Button : jObject; rule: DWord);
Const
 _cFuncName = 'jButton_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_setLayoutAll(env:PJNIEnv;this:jobject; Button : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jButton_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setLayoutAll2(env:PJNIEnv;this:jobject; Button : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, Button);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,Button,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_setLParamWidth(env:PJNIEnv;this:jobject; Button : jObject; w: DWord);
Const
 _cFuncName = 'jButton_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setLParamWidth2(env:PJNIEnv;this:jobject; Button : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, Button);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,Button,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_setLParamHeight(env:PJNIEnv;this:jobject; Button : jObject; h: DWord);
Const
 _cFuncName = 'jButton_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setLParamHeight2(env:PJNIEnv;this:jobject; Button : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, Button);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,Button,_jMethod,@_jParams);
end;

Procedure jButton_setId(env:PJNIEnv;this:jobject; Button : jObject; id: DWord);
Const
 _cFuncName = 'jButton_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setMarginLeft(env:PJNIEnv;this:jobject; Button : jObject; x: DWord);
Const
 _cFuncName = 'jButton_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_setMarginTop(env:PJNIEnv;this:jobject; Button : jObject; y: DWord);
Const
 _cFuncName = 'jButton_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jButton_setMarginRight(env:PJNIEnv;this:jobject; Button : jObject; x: DWord);
Const
 _cFuncName = 'jButton_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jButton_setMarginBottom(env:PJNIEnv;this:jobject; Button : jObject; y: DWord);
Const
 _cFuncName = 'jButton_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//
Procedure jButton_setOnClick(env:PJNIEnv;this:jobject;
                             Button : jObject);
 Const
  _cFuncName = 'jButton_setOnClick';
  _cFuncSig  = '(Landroid/widget/Button;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := Button;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jButton_setFocusable(env:PJNIEnv;this:jobject; Button : jObject; enabled: boolean);
Const
 _cFuncName = 'jButton_setFocusable';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Button;
 _jParams[1].z := JBool(enabled);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// CheckBox
//------------------------------------------------------------------------------

//
Function jCheckBox_Create(env:PJNIEnv;this:jobject;
                          context : jObject; SelfObj : TObject ) : jObject;
 Const
  _cFuncName = 'jCheckBox_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
Function jCheckBox_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jCheckBox_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

Procedure jCheckBox_Free (env:PJNIEnv;this:jobject; CheckBox : jObject);
  Const
   _cFuncName = 'jCheckBox_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := CheckBox;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,CheckBox);
  end;

Procedure jCheckBox_Free2(env:PJNIEnv;this:jobject; CheckBox : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
    cls := env^.GetObjectClass(env, CheckBox);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,CheckBox,_jMethod);
   env^.DeleteGlobalRef(env,CheckBox);
end;

//
Procedure jCheckBox_setXYWH(env:PJNIEnv;this:jobject;
                            CheckBox : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jCheckBox_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := CheckBox;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jCheckBox_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        CheckBox : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jCheckBox_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jCheckBox_setParent(env:PJNIEnv;this:jobject;
                              CheckBox : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jCheckBox_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := CheckBox;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


Procedure jCheckBox_setParent2(env:PJNIEnv;this:jobject;
                              CheckBox : jObject;ViewGroup : jObject);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
  cls := env^.GetObjectClass(env, ViewGroup);
  _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,ViewGroup,_jMethod,@_jParams);
 end;


// Java Function
Function jCheckBox_getText(env:PJNIEnv;this:jobject; CheckBox : jObject) : String;
 Const
  _cFuncName = 'jCheckBox_getText';
  _cFuncSig  = '(Ljava/lang/Object;)Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := CheckBox;
  _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
 end;

// Java Function
Procedure jCheckBox_setText(env:PJNIEnv;this:jobject;
                            CheckBox : jObject; Str : String);
 Const
  _cFuncName = 'jCheckBox_setText';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := CheckBox;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;


Procedure jCheckBox_setText2(env:PJNIEnv;this:jobject;
                            CheckBox : jObject; Str : String);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
   cls := env^.GetObjectClass(env, CheckBox);
  _jMethod:= env^.GetMethodID(env, cls, 'setText', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//
Procedure jCheckBox_setTextColor (env:PJNIEnv;this:jobject;
                                  CheckBox : jObject; color : DWord);
Const
 _cFuncName = 'jCheckBox_setTextColor';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := color;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setTextColor2(env:PJNIEnv;this:jobject;
                                  CheckBox : jObject; color : DWord);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := color;
  cls := env^.GetObjectClass(env, CheckBox);
  _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(I)V');
  env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
end;

//
Function  jCheckBox_isChecked          (env:PJNIEnv;this:jobject; CheckBox : jObject) : Boolean;
Const
 _cFuncName = 'jCheckBox_isChecked';
 _cFuncSig  = '(Ljava/lang/Object;)Z';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
 _jBool   : jBoolean;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := CheckBox;
 _jBool     := env^.CallBooleanMethodA(env,this,_jMethod,@_jParams);
 Result     := Boolean(_jBool);
end;

Function  jCheckBox_isChecked2(env:PJNIEnv;this:jobject; CheckBox : jObject) : Boolean;
var
 _jMethod : jMethodID = nil;
 _jBool   : jBoolean;
 cls: jClass;
begin
  cls := env^.GetObjectClass(env, CheckBox);
 _jMethod:= env^.GetMethodID(env, cls, 'isChecked2', '()Z');
 _jBool:= env^.CallBooleanMethod(env,CheckBox,_jMethod);
 Result:= Boolean(_jBool);
end;

//
Procedure jCheckBox_setChecked         (env:PJNIEnv;this:jobject;
                                        CheckBox : jObject; value : Boolean);
Const
 _cFuncName = 'jCheckBox_setChecked';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].z := JBool(value);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setChecked2(env:PJNIEnv;this:jobject;
                                        CheckBox : jObject; value : Boolean);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls := env^.GetObjectClass(env, CheckBox);
 _jMethod:= env^.GetMethodID(env, cls, 'setChecked2', '(Z)V');
 _jParams[0].z := JBool(value);
 env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
end;

// Font Height ( Pixel )
Procedure jCheckBox_setTextSize (env:PJNIEnv;this:jobject;
                                  CheckBox : jObject; size : DWord);
Const
 _cFuncName = 'jCheckBox_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setId(env:PJNIEnv;this:jobject; CheckBox : jObject; id: DWord);
Const
 _cFuncName = 'jCheckBox_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setMarginLeft(env:PJNIEnv;this:jobject; CheckBox : jObject; x: DWord);
Const
 _cFuncName = 'jCheckBox_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setMarginTop(env:PJNIEnv;this:jobject; CheckBox : jObject; y: DWord);
Const
 _cFuncName = 'jCheckBox_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setMarginRight(env:PJNIEnv;this:jobject; CheckBox : jObject; x: DWord);
Const
 _cFuncName = 'jCheckBox_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setMarginBottom(env:PJNIEnv;this:jobject; CheckBox : jObject; y: DWord);
Const
 _cFuncName = 'jCheckBox_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setLParamWidth(env:PJNIEnv;this:jobject; CheckBox : jObject; w: DWord);
Const
 _cFuncName = 'jCheckBox_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setLParamWidth2(env:PJNIEnv;this:jobject; CheckBox : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, CheckBox);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setLParamHeight(env:PJNIEnv;this:jobject; CheckBox : jObject; h: DWord);
Const
 _cFuncName = 'jCheckBox_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setLParamHeight2(env:PJNIEnv;this:jobject; CheckBox : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, CheckBox);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
end;


//by jmpessoa
Procedure jCheckBox_addLParamsParentRule(env:PJNIEnv;this:jobject; CheckBox : jObject; rule: DWord);
Const
 _cFuncName = 'jCheckBox_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_addLParamsAnchorRule(env:PJNIEnv;this:jobject; CheckBox : jObject; rule: DWord);
Const
 _cFuncName = 'jCheckBox_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jCheckBox_setLayoutAll(env:PJNIEnv;this:jobject; CheckBox : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jCheckBox_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := CheckBox;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCheckBox_setLayoutAll2(env:PJNIEnv;this:jobject; CheckBox : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, CheckBox);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,CheckBox,_jMethod,@_jParams);
end;
//------------------------------------------------------------------------------
// RadioButton
//------------------------------------------------------------------------------

//
Function jRadioButton_Create(env:PJNIEnv; this:jobject;
                          context : jObject; SelfObj : TObject ) : jObject;
 Const
  _cFuncName = 'jRadioButton_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

function jRadioButton_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jRadioButton_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jRadioButton_Free(env:PJNIEnv;this:jobject; RadioButton : jObject);
  Const
   _cFuncName = 'jRadioButton_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := RadioButton;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,RadioButton);
  end;

//by jmpessoa
Procedure jRadioButton_Free2(env:PJNIEnv;this:jobject; RadioButton : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, RadioButton);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,RadioButton,_jMethod);
  env^.DeleteGlobalRef(env,RadioButton);
end;
//
Procedure jRadioButton_setXYWH(env:PJNIEnv;this:jobject;
                            RadioButton : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jRadioButton_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := RadioButton;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jRadioButton_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        RadioButton : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jRadioButton_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jRadioButton_setParent(env:PJNIEnv;this:jobject;
                              RadioButton : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jRadioButton_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := RadioButton;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


// Java Function
Function jRadioButton_getText(env:PJNIEnv;this:jobject; RadioButton : jObject) : String;
 Const
  _cFuncName = 'jRadioButton_getText';
  _cFuncSig  = '(Ljava/lang/Object;)Ljava/lang/String;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
  _jString : jString;
  _jBoolean: jBoolean;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := RadioButton;
  _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
 end;

// Java Function
Procedure jRadioButton_setText(env:PJNIEnv;this:jobject;
                            RadioButton : jObject; Str : String);
 Const
  _cFuncName = 'jRadioButton_setText';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := RadioButton;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;


Procedure jRadioButton_setText2(env:PJNIEnv;this:jobject;
                            RadioButton : jObject; Str : String);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  cls := env^.GetObjectClass(env, RadioButton);
 _jMethod:= env^.GetMethodID(env, cls, 'setText', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//
Procedure jRadioButton_setTextColor (env:PJNIEnv;this:jobject;
                                  RadioButton : jObject; color : DWord);
Const
 _cFuncName = 'jRadioButton_setTextColor';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := color;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setTextColor2(env:PJNIEnv;this:jobject;
                                  RadioButton : jObject; color : DWord);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].i := color;
  cls := env^.GetObjectClass(env, RadioButton);
  _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(I)V');
  env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
end;
//
Function  jRadioButton_isChecked          (env:PJNIEnv;this:jobject; RadioButton : jObject) : Boolean;
Const
 _cFuncName = 'jRadioButton_isChecked';
 _cFuncSig  = '(Ljava/lang/Object;)Z';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
 _jBool   : jBoolean;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := RadioButton;
 _jBool     := env^.CallBooleanMethodA(env,this,_jMethod,@_jParams);
 Result     := Boolean(_jBool);
end;


Function  jRadioButton_isChecked2(env:PJNIEnv;this:jobject; RadioButton : jObject) : Boolean;
var
 _jMethod : jMethodID = nil;
 _jBool   : jBoolean;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, RadioButton);
 _jMethod:= env^.GetMethodID(env, cls, 'isChecked', '()Z');
 _jBool:= env^.CallBooleanMethod(env,RadioButton,_jMethod);
 Result:= Boolean(_jBool);
end;

//
Procedure jRadioButton_setChecked(env:PJNIEnv;this:jobject;
                                        RadioButton : jObject; value : Boolean);
Const
 _cFuncName = 'jRadioButton_setChecked';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].z := JBool(value);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jRadioButton_setChecked2(env:PJNIEnv;this:jobject;
                                        RadioButton : jObject; value : Boolean);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].z := JBool(value);
   cls := env^.GetObjectClass(env, RadioButton);
 _jMethod:= env^.GetMethodID(env, cls, 'setChecked', '(Z)V');
 env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
end;

// Font Height ( Pixel )
Procedure jRadioButton_setTextSize (env:PJNIEnv;this:jobject;
                                  RadioButton : jObject; size : DWord);
Const
 _cFuncName = 'jRadioButton_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setId(env:PJNIEnv;this:jobject; RadioButton : jObject; id: DWord);
Const
 _cFuncName = 'jRadioButton_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setMarginLeft(env:PJNIEnv;this:jobject; RadioButton : jObject; x: DWord);
Const
 _cFuncName = 'jRadioButton_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setMarginTop(env:PJNIEnv;this:jobject; RadioButton : jObject; y: DWord);
Const
 _cFuncName = 'jRadioButton_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setMarginRight(env:PJNIEnv;this:jobject; RadioButton : jObject; x: DWord);
Const
 _cFuncName = 'jRadioButton_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setMarginBottom(env:PJNIEnv;this:jobject; RadioButton : jObject; y: DWord);
Const
 _cFuncName = 'jRadioButton_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setLParamWidth(env:PJNIEnv;this:jobject; RadioButton : jObject; w: DWord);
Const
 _cFuncName = 'jRadioButton_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setLParamWidth2(env:PJNIEnv;this:jobject; RadioButton : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, RadioButton);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setLParamHeight(env:PJNIEnv;this:jobject; RadioButton : jObject; h: DWord);
Const
 _cFuncName = 'jRadioButton_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setLParamHeight2(env:PJNIEnv;this:jobject; RadioButton : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, RadioButton);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
end;
//by jmpessoa
Procedure jRadioButton_addLParamsParentRule(env:PJNIEnv;this:jobject; RadioButton : jObject; rule: DWord);
Const
 _cFuncName = 'jRadioButton_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_addLParamsAnchorRule(env:PJNIEnv;this:jobject; RadioButton : jObject; rule: DWord);
Const
 _cFuncName = 'jRadioButton_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jRadioButton_setLayoutAll(env:PJNIEnv;this:jobject; RadioButton : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jRadioButton_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := RadioButton;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jRadioButton_setLayoutAll2(env:PJNIEnv;this:jobject; RadioButton : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, RadioButton);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,RadioButton,_jMethod,@_jParams);
end;
//------------------------------------------------------------------------------
// ProgressBar
//------------------------------------------------------------------------------

// Java Function
Function jProgressBar_Create(env:PJNIEnv;this:jobject;
                             context : jObject; SelfObj : TObject; Style : DWord ) : jObject;
 Const
  _cFuncName = 'jProgressBar_Create';
  _cFuncSig  = '(Landroid/content/Context;JI)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..2] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  _jParams[2].i := Style;
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jProgressBar_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject; Style: DWord): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jProgressBar_Create2', '(JI)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  _jParams[1].i := Style;
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jProgressBar_Free (env:PJNIEnv;this:jobject; ProgressBar : jObject);
  Const
   _cFuncName = 'jProgressBar_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ProgressBar;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ProgressBar);
  end;

Procedure jProgressBar_Free2(env:PJNIEnv;this:jobject; ProgressBar : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
   cls := env^.GetObjectClass(env, ProgressBar);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,ProgressBar,_jMethod);
   env^.DeleteGlobalRef(env,ProgressBar);
end;

//
Procedure jProgressBar_setXYWH(env:PJNIEnv;this:jobject;
                               ProgressBar : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jProgressBar_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ProgressBar;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jProgressBar_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ProgressBar : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jProgressBar_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jProgressBar_setParent(env:PJNIEnv;this:jobject;
                                 ProgressBar : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jProgressBar_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ProgressBar;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


Procedure jProgressBar_setParent2(env:PJNIEnv;this:jobject;
                                 ProgressBar : jObject;ViewGroup : jObject);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
    cls := env^.GetObjectClass(env, ProgressBar);
 _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
 end;

//
Function  jProgressBar_getProgress (env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;
Const
 _cFuncName = 'jProgressBar_getProgress';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := ProgressBar;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Function  jProgressBar_getProgress2(env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, ProgressBar);
  _jMethod:= env^.GetMethodID(env, cls, 'getProgress2', '()I');
 Result     := env^.CallIntMethod(env,ProgressBar,_jMethod);
end;

//
Procedure jProgressBar_setProgress (env:PJNIEnv;this:jobject;
                                    ProgressBar : jObject; value : Integer);
Const
 _cFuncName = 'jProgressBar_setProgress';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := value;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jProgressBar_setProgress2(env:PJNIEnv;this:jobject;
                                    ProgressBar : jObject; value : Integer);
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
  cls: jClass;
begin
 _jParams[0].i := value;
  cls := env^.GetObjectClass(env, ProgressBar);
 _jMethod:= env^.GetMethodID(env, cls, 'setProgressEx', '(I)V');
 env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setMax (env:PJNIEnv;this:jobject;
                                    ProgressBar : jObject; value : Integer);
Const
 _cFuncName = 'jProgressBar_setMax';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := value;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setMax2(env:PJNIEnv;this:jobject;
                                    ProgressBar : jObject; value : Integer);
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := value;
  cls := env^.GetObjectClass(env, ProgressBar);
  _jMethod:= env^.GetMethodID(env, cls, 'SetMax2', '(I)V');
 env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
end;

//by jmpessoa
Function  jProgressBar_getMax(env:PJNIEnv;this:jobject; ProgressBar : jObject) : Integer;
Const
 _cFuncName = 'jProgressBar_getMax';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := ProgressBar;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Function  jProgressBar_getMax2(env:PJNIEnv; this:jobject; ProgressBar : jObject): Integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls:= env^.GetObjectClass(env, ProgressBar);
  _jMethod:= env^.GetMethodID(env, cls, 'getMax2', '()I');
 Result:= env^.CallIntMethod(env,ProgressBar,_jMethod);
end;


//by jmpessoa
Procedure jProgressBar_setId(env:PJNIEnv;this:jobject; ProgressBar : jObject; id: DWord);
Const
 _cFuncName = 'jProgressBar_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jProgressBar_setMarginLeft(env:PJNIEnv;this:jobject; ProgressBar : jObject; x: DWord);
Const
 _cFuncName = 'jProgressBar_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setMarginTop(env:PJNIEnv;this:jobject; ProgressBar : jObject; y: DWord);
Const
 _cFuncName = 'jProgressBar_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jProgressBar_setMarginRight(env:PJNIEnv;this:jobject; ProgressBar : jObject; x: DWord);
Const
 _cFuncName = 'jProgressBar_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setMarginBottom(env:PJNIEnv;this:jobject; ProgressBar : jObject; y: DWord);
Const
 _cFuncName = 'jProgressBar_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setLParamWidth2(env:PJNIEnv;this:jobject; ProgressBar : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ProgressBar);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
end;

Procedure jProgressBar_setLParamWidth(env:PJNIEnv;this:jobject; ProgressBar : jObject; w: DWord);
Const
 _cFuncName = 'jProgressBar_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setLParamHeight(env:PJNIEnv;this:jobject; ProgressBar : jObject; h: DWord);
Const
 _cFuncName = 'jProgressBar_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jProgressBar_setLParamHeight2(env:PJNIEnv;this:jobject; ProgressBar : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ProgressBar);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_addLParamsParentRule(env:PJNIEnv;this:jobject; ProgressBar : jObject; rule: DWord);
Const
 _cFuncName = 'jProgressBar_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ProgressBar : jObject; rule: DWord);
Const
 _cFuncName = 'jProgressBar_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jProgressBar_setLayoutAll(env:PJNIEnv;this:jobject; ProgressBar : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jProgressBar_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ProgressBar;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jProgressBar_setLayoutAll2(env:PJNIEnv;this:jobject; ProgressBar : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ProgressBar);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ProgressBar,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// ImageView
//------------------------------------------------------------------------------

//
Function  jImageView_Create  (env:PJNIEnv;this:jobject;
                              context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jImageView_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jImageView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jImageView_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jImageView_Free   (env:PJNIEnv;this:jobject; ImageView : jObject);
  Const
   _cFuncName = 'jImageView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ImageView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ImageView);
  end;

Procedure jImageView_Free2(env:PJNIEnv;this:jobject; ImageView : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
    cls:= env^.GetObjectClass(env, ImageView);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,ImageView,_jMethod);
   env^.DeleteGlobalRef(env,ImageView);
end;

// 
Procedure jImageView_setXYWH(env:PJNIEnv;this:jobject;
                             ImageView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jImageView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jImageView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ImageView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jImageView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


// 
Procedure jImageView_setParent(env:PJNIEnv;this:jobject;
                               ImageView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jImageView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;
 
//
Procedure jImageView_setImage(env:PJNIEnv;this:jobject;
                              ImageView : jObject; Str : String);
 Const
  _cFuncName = 'jImageView_setImage';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageView;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

Procedure jImageView_setImage2(env:PJNIEnv;this:jobject;
                              ImageView : jObject; Str : String);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
    cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'setImage', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//by jmpessoa
Procedure jImageView_setBitmapImage(env:PJNIEnv;this:jobject;
                                    ImageView : jObject; bitmap : jObject);
 Const
  _cFuncName = 'jImageView_setBitmapImage';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/graphics/Bitmap;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageView;
  _jParams[1].l := bitmap;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


Procedure jImageView_setBitmapImage2(env:PJNIEnv;this:jobject;
                                    ImageView : jObject; bitmap : jObject);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := bitmap;
    cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'setBitmapImage', '(Landroid/graphics/Bitmap;)V');
  env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
 end;

Procedure jImageView_SetImageByResIdentifier(env:PJNIEnv;this:jobject; ImageView : jObject; _imageResIdentifier: string);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, PChar(_imageResIdentifier) );
  cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'SetImageByResIdentifier', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//by jmpessoa
Procedure jImageView_setId(env:PJNIEnv;this:jobject; ImageView : jObject; id: DWord);
Const
 _cFuncName = 'jImageView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setMarginLeft(env:PJNIEnv;this:jobject; ImageView : jObject; x: DWord);
Const
 _cFuncName = 'jImageView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setMarginTop(env:PJNIEnv;this:jobject; ImageView : jObject; y: DWord);
Const
 _cFuncName = 'jImageView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setMarginRight(env:PJNIEnv;this:jobject; ImageView : jObject; x: DWord);
Const
 _cFuncName = 'jImageView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setMarginBottom(env:PJNIEnv;this:jobject; ImageView : jObject; y: DWord);
Const
 _cFuncName = 'jImageView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setLParamWidth2(env:PJNIEnv;this:jobject; ImageView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ImageView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
end;

Procedure jImageView_setLParamWidth(env:PJNIEnv;this:jobject; ImageView : jObject; w: DWord);
Const
 _cFuncName = 'jImageView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setLParamHeight(env:PJNIEnv;this:jobject; ImageView : jObject; h: DWord);
Const
 _cFuncName = 'jImageView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jImageView_setLParamHeight2(env:PJNIEnv;this:jobject; ImageView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ImageView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_addLParamsParentRule(env:PJNIEnv;this:jobject; ImageView : jObject; rule: DWord);
Const
 _cFuncName = 'jImageView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ImageView : jObject; rule: DWord);
Const
 _cFuncName = 'jImageView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageView_setLayoutAll(env:PJNIEnv;this:jobject; ImageView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jImageView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jImageView_setLayoutAll2(env:PJNIEnv;this:jobject; ImageView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ImageView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ImageView,_jMethod,@_jParams);
end;
//by jmpessoa
function jImageView_getLParamHeight(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
Const
 _cFuncName = 'jImageView_getLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := ImageView;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

function jImageView_getLParamHeight2(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'getLParamHeight', '()I');
 Result:= env^.CallIntMethod(env,ImageView,_jMethod);
end;

//by jmpessoa
function jImageView_getLParamWidth(env:PJNIEnv;this:jobject; ImageView : jObject): integer;
Const
  _cFuncName = 'jImageView_getLParamWidth';
  _cFuncSig  = '(Ljava/lang/Object;)I';
Var
  _jMethod : jMethodID = nil;
  _jParams : jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams.l := ImageView;
  Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;


function jImageView_getLParamWidth2(env:PJNIEnv;this:jobject; ImageView : jObject): integer;
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'getLParamWidth', '()I');
  Result:= env^.CallIntMethod(env,ImageView,_jMethod);
end;

function jImageView_GetBitmapHeight(env:PJNIEnv;this:jobject; ImageView : jObject ): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'GetBitmapHeight', '()I');
 Result:= env^.CallIntMethod(env,ImageView,_jMethod);
end;


function jImageView_GetBitmapWidth(env:PJNIEnv;this:jobject; ImageView : jObject): integer;
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, ImageView);
 _jMethod:= env^.GetMethodID(env, cls, 'GetBitmapWidth', '()I');
  Result:= env^.CallIntMethod(env,ImageView,_jMethod);
end;
//------------------------------------------------------------------------------
// ListView
//------------------------------------------------------------------------------
//
function  jListView_Create(env:PJNIEnv;this:jobject;
                             context : jObject; SelfObj : TObject; hasWidget: integer; delimiter: string) : jObject;
const
  _cFuncName = 'jListView_Create';
  _cFuncSig  = '(Landroid/content/Context;JILjava/lang/String;)Ljava/lang/Object;';
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..3] of jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  _jParams[2].i := hasWidget;
  _jParams[3].l := env^.NewStringUTF(env, pchar(delimiter) );
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[3].l);
end;

//by jmpessoa
function jListView_Create2(env:PJNIEnv; this:jobject; SelfObj: TObject;
                                         {ftColor: integer; ftSize: integer;} widget: integer;
                                         widgetText: string; image: jObject;
                                         txtDecorated: integer; itemLay: integer; txtSizeDec: integer; txtAlign: integer): jObject;
var
 _jMethod: jMethodID = nil;
 _jParams: array[0..7] of jValue;
 cls: jClass;
begin
 _jParams[0].j := Int64(SelfObj);
 //_jParams[1].i := ftColor;
// _jParams[2].i := ftSize;
 _jParams[1].i := widget;
 _jParams[2].l := env^.NewStringUTF(env, PChar(widgetText));
 _jParams[3].l := image;
 _jParams[4].i := txtDecorated;
 _jParams[5].i := itemLay;
 _jParams[6].i := txtSizeDec;
 _jParams[7].i := txtAlign;
  cls:= Get_gjClass(env); {global}
  {jmpessoa/warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
 _jMethod:= env^.GetMethodID(env, cls, 'jListView_Create2',
                                       '(JILjava/lang/String;Landroid/graphics/Bitmap;IIII)Ljava/lang/Object;');
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[2].l);
end;


//by jmpessoa
function jListView_Create3(env:PJNIEnv; this:jobject; SelfObj: TObject;
                                         {ftColor: integer; ftSize: integer;} widget: integer;
                                         widgetText: string;
                                         txtDecorated: integer; itemLay: integer; txtSizeDec: integer; txtAlign: integer): jObject;
var
 _jMethod: jMethodID = nil;
 _jParams: array[0..6] of jValue;
 cls: jClass;
begin
 _jParams[0].j := Int64(SelfObj);
// _jParams[1].i := ftColor;
// _jParams[2].i := ftSize;
 _jParams[1].i := widget;
 _jParams[2].l := env^.NewStringUTF(env, pchar(widgetText) );
 _jParams[3].i := txtDecorated;
 _jParams[4].i := itemLay;
 _jParams[5].i := txtSizeDec;
 _jParams[6].i := txtAlign;
  cls:= Get_gjClass(env); {global}

  {jmpessoa/warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
 _jMethod:= env^.GetMethodID(env, cls, 'jListView_Create3',
                                       '(JILjava/lang/String;IIII)Ljava/lang/Object;');
  Result:= env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result:= env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[2].l);
end;

//
Procedure jListView_Free(env:PJNIEnv;this:jobject; ListView : jObject);
  Const
   _cFuncName = 'jListView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ListView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ListView);
  end;

Procedure jListView_Free2(env:PJNIEnv;this:jobject; ListView : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
   cls:= env^.GetObjectClass(env, ListView);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,ListView,_jMethod);
   env^.DeleteGlobalRef(env, ListView);
end;

//
procedure jListView_setXYWH(env:PJNIEnv;this:jobject;
                            ListView: jObject;x,y,w,h : integer);
const
  _cFuncName = 'jListView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ListView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jListView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ListView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jListView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//
Procedure jListView_setParent(env:PJNIEnv;this:jobject;
                              ListView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jListView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ListView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jListView_setParent2(env:PJNIEnv;this:jobject;
                              ListView : jObject;ViewGroup : jObject);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].l := ViewGroup;
    cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

//
Procedure jListView_setTextColor (env:PJNIEnv;this:jobject;
                                  ListView : jObject; color : DWord);
Const
  _cFuncName = 'jListView_setTextColor';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ListView;
  _jParams[1].i := color;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jListView_setTextColor2(env:PJNIEnv;this:jobject;
                                  ListView : jObject; color : DWord; index: integer);
 var
   _jMethod : jMethodID = nil;
   _jParams : array[0..1] of jValue;
   cls: jClass;
 begin
   _jParams[0].i := color;
   _jParams[1].i := index;
   cls := env^.GetObjectClass(env, ListView);
   _jMethod:= env^.GetMethodID(env, cls, 'setTextColor2', '(II)V');
   env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
 end;

//
Procedure jListView_setTextSize(env:PJNIEnv;this:jobject; ListView : jObject; size  : DWord);
Const
 _cFuncName = 'jListView_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := size;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jListView_setTextSize2  (env:PJNIEnv;this:jobject;
                                  ListView : jObject; size  : DWord; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 cls: jClass;
begin
 _jParams[0].i := size;
 _jParams[1].i := index;
   cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextSize2', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

//
Procedure jListView_setItemPosition    (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Pos: integer; y:Integer );

Const
 _cFuncName = 'jListView_setItemPosition';
 _cFuncSig  = '(Ljava/lang/Object;II)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..2] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := Pos;
 _jParams[2].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jListView_setItemPosition2   (env:PJNIEnv;this:jobject;
                                        ListView : jObject; Pos: integer; y:Integer );

var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 cls: jClass;
begin
 _jParams[0].i := Pos;
 _jParams[1].i := y;
   cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setItemPosition', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

// Java Function
Procedure jListView_add(env:PJNIEnv;this:jobject; ListView : jObject; Str : string;
                                        delimiter: string; fontColor: integer; fontSize: integer; hasWidgetItem: integer);
const
  _cFuncName = 'jListView_add';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;III)V';
var
  _jMethod: jMethodID = nil;
  _jParams: array[0..5] of jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ListView;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  _jParams[2].l := env^.NewStringUTF(env, pchar(delimiter) );
  _jParams[3].i := fontColor;
  _jParams[4].i := fontSize;
  _jParams[5].i := hasWidgetItem;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[2].l);

end;

//by jmpessoa
Procedure jListView_add2(env:PJNIEnv;this:jobject; ListView: jObject; Str: string; delimiter: string);
var
  _jMethod: jMethodID = nil;
  _jParams: array[0..1] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  _jParams[1].l := env^.NewStringUTF(env, pchar(delimiter) );
  cls:= env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'add2', '(Ljava/lang/String;Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env, cls);  // <---- Added this for bug fix! 09-Sept-2014 [thanks to @Fatih!]
end;

Procedure jListView_add22(env:PJNIEnv;this:jobject; ListView: jObject; Str: string; delimiter: string; image: jObject);
var
  _jMethod: jMethodID = nil;
  _jParams: array[0..2] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  _jParams[1].l := env^.NewStringUTF(env, pchar(delimiter) );
  _jParams[2].l := image;
  cls := env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'add22', '(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;)V');
  env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env, cls);  // <---- Added this for bug fix! 09-Sept-2014
end;

//by jmpessoa
Procedure jListView_add3(env:PJNIEnv;this:jobject; ListView : jObject; Str : string;
       delimiter: string; fontColor: integer; fontSize: integer; widgetItem: integer; widgetText: string;  image: jObject);
var
  _jMethod: jMethodID = nil;
  _jParams: array[0..6] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  _jParams[1].l := env^.NewStringUTF(env, pchar(delimiter) );
  _jParams[2].i := fontColor;
  _jParams[3].i := fontSize;
  _jParams[4].i := widgetItem;
  _jParams[5].l := env^.NewStringUTF(env, pchar(widgetText) );
  _jParams[6].l := image;
  cls:= env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'add3', '(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;Landroid/graphics/Bitmap;)V');
  env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[5].l);
  env^.DeleteLocalRef(env, cls);  // <---- Added this for bug fix! 09-Sept-2014
end;


//by jmpessoa
Procedure jListView_add4(env:PJNIEnv;this:jobject; ListView : jObject; Str : string;
       delimiter: string; fontColor: integer; fontSize: integer; widgetItem: integer; widgetText: string);
var
  _jMethod: jMethodID = nil;
  _jParams: array[0..5] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
  _jParams[1].l := env^.NewStringUTF(env, pchar(delimiter) );
  _jParams[2].i := fontColor;
  _jParams[3].i := fontSize;
  _jParams[4].i := widgetItem;
  _jParams[5].l := env^.NewStringUTF(env, pchar(widgetText) );
  cls:= env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'add4', '(Ljava/lang/String;Ljava/lang/String;IIILjava/lang/String;)V');
  env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[5].l);
  env^.DeleteLocalRef(env, cls);  // <---- Added this for bug fix! 09-Sept-2014
end;

Procedure jListView_clear              (env:PJNIEnv;this:jobject;
                                        ListView : jObject);
Const
 _cFuncName = 'jListView_clear';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l:= ListView;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
end;

//by jmpessoa
Procedure jListView_clear2(env:PJNIEnv; this:jobject; ListView: jObject);
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'clear', '()V');
  env^.CallVoidMethod(env,ListView,_jMethod);
end;

Procedure jListView_delete             (env:PJNIEnv;this:jobject;
                                        ListView : jObject; index : integer);
Const
 _cFuncName = 'jListView_delete';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := index;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_delete2(env:PJNIEnv;this:jobject; ListView : jObject; index : integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
   cls: jClass;
begin
 _jParams[0].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'delete', '(I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setImageItem(env:PJNIEnv;this:jobject; ListView : jObject; bitmap: jObject; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].l := bitmap;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setImageItem', '(Landroid/graphics/Bitmap;I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setImageItem(env:PJNIEnv;this:jobject; ListView : jObject; imgResIdentifier: string; index: integer); overload;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, PChar(imgResIdentifier) );;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setImageItem', '(Ljava/lang/String;I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
   env^.DeleteLocalRef(env,_jParams[0].l);
end;

//by jmpessoa
Procedure jListView_setId(env:PJNIEnv;this:jobject; ListView : jObject; id: DWord);
Const
 _cFuncName = 'jListView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setTextSizeDecorated(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index:integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextSizeDecorated', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setTextDecorated(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextDecorated', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setTextAlign(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setTextAlign', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setItemLayout(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setItemLayout', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setWidgetItem(env:PJNIEnv;this:jobject; ListView : jObject; value: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setWidgetItem', '(I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setWidgetItem2(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setWidgetItem', '(II)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setWidgetItem3(env:PJNIEnv;this:jobject; ListView : jObject; value: integer; txt: string; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..2] of jValue;
   cls: jClass;
begin
 _jParams[0].i := value;
 _jParams[1].l := env^.NewStringUTF(env, pchar(txt) );
 _jParams[2].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setWidgetItem', '(ILjava/lang/String;I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

Procedure jListView_setWidgetText(env:PJNIEnv;this:jobject; ListView : jObject; txt: string; index: integer);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
   cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(txt) );
 _jParams[1].i := index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'setWidgetText', '(Ljava/lang/String;I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;

function jListView_IsItemChecked(env:PJNIEnv;this:jobject; ListView : jObject; index: integer): boolean;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
 _jBool: jBoolean;
begin
 _jParams[0].i:= index;
 cls := env^.GetObjectClass(env, ListView);
 _jMethod:= env^.GetMethodID(env, cls, 'isItemChecked', '(I)Z');
 _jBool:= env^.CallBooleanMethodA(env,ListView,_jMethod,@_jParams);
 Result:= Boolean(_jBool);
end;

function jListView_GetItemText(env:PJNIEnv;this:jobject; ListView : jObject; index: integer): String;
var
  _jMethod : jMethodID = nil;
  _jString : jString;
  _jBoolean: jBoolean;
  cls: jClass;
   _jParams : array[0..0] of jValue;
begin
   _jParams[0].i:= index;
  cls := env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'getItemText', '(I)Ljava/lang/String;');
  _jString   := env^.CallObjectMethodA(env,ListView,_jMethod, @_jParams);
  Case _jString = nil of
   True : Result    := '';
   False: begin
            _jBoolean := JNI_False;
            Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
          end;
  end;
end;

function jListView_GetCount(env:PJNIEnv; this:jobject; ListView : jObject): integer;
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'GetSize', '()I');
  Result:= env^.CallIntMethod(env,ListView,_jMethod);
end;

Procedure jListView_setMarginLeft(env:PJNIEnv;this:jobject; ListView : jObject; x: DWord);
Const
 _cFuncName = 'jListView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//by jmpessoa
Procedure jListView_setMarginTop(env:PJNIEnv;this:jobject; ListView : jObject; y: DWord);
Const
 _cFuncName = 'jListView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jListView_setMarginRight(env:PJNIEnv;this:jobject; ListView : jObject; x: DWord);
Const
 _cFuncName = 'jListView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setMarginBottom(env:PJNIEnv;this:jobject; ListView : jObject; y: DWord);
Const
 _cFuncName = 'jListView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setLParamWidth2(env:PJNIEnv;this:jobject; ListView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ListView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

Procedure jListView_setLParamWidth(env:PJNIEnv;this:jobject; ListView : jObject; w: DWord);
Const
 _cFuncName = 'jListView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setLParamHeight(env:PJNIEnv;this:jobject; ListView : jObject; h: DWord);
Const
 _cFuncName = 'jListView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jListView_setLParamHeight2(env:PJNIEnv;this:jobject; ListView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ListView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;


//by jmpessoa
Procedure jListView_addLParamsParentRule(env:PJNIEnv;this:jobject; ListView : jObject; rule: DWord);
Const
 _cFuncName = 'jListView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ListView : jObject; rule: DWord);
Const
 _cFuncName = 'jListView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jListView_setLayoutAll(env:PJNIEnv;this:jobject; ListView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jListView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ListView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jListView_setLayoutAll2(env:PJNIEnv;this:jobject; ListView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ListView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ListView,_jMethod,@_jParams);
end;

procedure jListView_SetHighLightSelectedItem(env: PJNIEnv; this: JObject; _jlistview: JObject; _value: boolean);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].z:= JBool(_value);
  jCls:= env^.GetObjectClass(env, _jlistview);
  jMethod:= env^.GetMethodID(env, jCls, 'SetHighLightSelectedItem', '(Z)V');
  env^.CallVoidMethodA(env, _jlistview, jMethod, @jParams);
end;


procedure jListView_SetHighLightSelectedItemColor(env: PJNIEnv; this: JObject; _jlistview: JObject; _color: integer);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].i:= _color;
  jCls:= env^.GetObjectClass(env, _jlistview);
  jMethod:= env^.GetMethodID(env, jCls, 'SetHighLightSelectedItemColor', '(I)V');
  env^.CallVoidMethodA(env, _jlistview, jMethod, @jParams);
end;

//------------------------------------------------------------------------------
// ScrollView
//------------------------------------------------------------------------------

//
Function  jScrollView_Create  (env:PJNIEnv;this:jobject;
                               context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jScrollView_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jScrollView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jScrollView_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jScrollView_Free   (env:PJNIEnv;this:jobject; ScrollView : jObject);
  Const
   _cFuncName = 'jScrollView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ScrollView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ScrollView);
  end;

Procedure jScrollView_Free2(env:PJNIEnv;this:jobject; ScrollView : jObject);
var
   _jMethod: jMethodID = nil;
   cls: jClass;
begin
 cls:= env^.GetObjectClass(env, ScrollView);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env, ScrollView, _jMethod);
 env^.DeleteGlobalRef(env, ScrollView);
end;
// 
Procedure jScrollView_setXYWH(env:PJNIEnv;this:jobject;
                              ScrollView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jScrollView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jScrollView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jScrollView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


// 
Procedure jScrollView_setParent(env:PJNIEnv;this:jobject;
                                ScrollView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jScrollView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jScrollView_setParent2(env:PJNIEnv;this:jobject;
                                ScrollView : jObject;ViewGroup : jObject);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
    cls := env^.GetObjectClass(env, ScrollView);
 _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
 end;
  
//
Procedure jScrollView_setScrollSize(env:PJNIEnv;this:jobject;
                                    ScrollView : jObject; size : integer);
 Const
  _cFuncName = 'jScrollView_setScrollSize';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].i := size;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;


Procedure jScrollView_setScrollSize2(env:PJNIEnv;this:jobject;
                                    ScrollView : jObject; size : integer);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].i := size;
    cls := env^.GetObjectClass(env, ScrollView);
 _jMethod:= env^.GetMethodID(env, cls, 'setScrollSize', '(I)V');
  env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
 end;

//
Function jScrollView_getView(env:PJNIEnv;this:jobject;
                             ScrollView : jObject) : jObject;
 Const 
  _cFuncName = 'jScrollView_getView';
  _cFuncSig  = '(Ljava/lang/Object;)Landroid/view/ViewGroup;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l := ScrollView;
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 end;

//by jmpessoa
Procedure jScrollView_setId(env:PJNIEnv;this:jobject; ScrollView : jObject; id: DWord);
Const
 _cFuncName = 'jScrollView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jScrollView_setMarginLeft(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Const
 _cFuncName = 'jScrollView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_setMarginTop(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Const
 _cFuncName = 'jScrollView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jScrollView_setMarginRight(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Const
 _cFuncName = 'jScrollView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_setMarginBottom(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Const
 _cFuncName = 'jScrollView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_setLParamWidth2(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ScrollView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;

Procedure jScrollView_setLParamWidth(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Const
 _cFuncName = 'jScrollView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_setLParamHeight(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);
Const
 _cFuncName = 'jScrollView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jScrollView_setLParamHeight2(env:PJNIEnv;this:jobject; ScrollView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ScrollView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_addLParamsParentRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Const
 _cFuncName = 'jScrollView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Const
 _cFuncName = 'jScrollView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jScrollView_setLayoutAll(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jScrollView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jScrollView_setLayoutAll2(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ScrollView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;
//----------------------------------------
//Panel - new by jmpessoa
//----------------------------------------
Function  jPanel_Create  (env:PJNIEnv;this:jobject;
                               context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jPanel_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

function jPanel_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jPanel_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

Procedure jPanel_Free   (env:PJNIEnv;this:jobject; Panel : jObject);
  Const
   _cFuncName = 'jPanel_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := Panel;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,Panel);
  end;

Procedure jPanel_Free2(env:PJNIEnv;this:jobject; Panel : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, Panel);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,Panel,_jMethod);
  env^.DeleteGlobalRef(env,Panel);
end;

////by jmpessoa
Procedure jPanel_setXYWH(env:PJNIEnv;this:jobject;
                              Panel : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jPanel_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Panel;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

//by jmpessoa
Procedure jPanel_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        Panel : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jPanel_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//by jmpessoa
Procedure jPanel_setParent(env:PJNIEnv;this:jobject;
                                Panel : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jPanel_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Panel;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jPanel_setParent2(env:PJNIEnv;this:jobject;
                                Panel : jObject;ViewGroup : jObject);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
    cls := env^.GetObjectClass(env, Panel);
 _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
 end;

//by jmpessoa
Function jPanel_getView(env:PJNIEnv;this:jobject;
                             Panel : jObject) : jObject;
 Const
  _cFuncName = 'jPanel_getView';
  _cFuncSig  = '(Ljava/lang/Object;)Landroid/widget/RelativeLayout;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l := Panel;
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 end;

//by jmpessoa
Procedure jPanel_setId(env:PJNIEnv;this:jobject; Panel : jObject; id: DWord);
Const
 _cFuncName = 'jPanel_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setMarginLeft(env:PJNIEnv;this:jobject; Panel : jObject; x: DWord);
Const
 _cFuncName = 'jPanel_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setMarginTop(env:PJNIEnv;this:jobject; Panel : jObject; y: DWord);
Const
 _cFuncName = 'jPanel_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setMarginRight(env:PJNIEnv;this:jobject; Panel : jObject; x: DWord);
Const
 _cFuncName = 'jPanel_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setMarginBottom(env:PJNIEnv;this:jobject; Panel : jObject; y: DWord);
Const
 _cFuncName = 'jPanel_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setLParamWidth2(env:PJNIEnv;this:jobject; Panel : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, Panel);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
end;

Procedure jPanel_setLParamWidth(env:PJNIEnv;this:jobject; Panel : jObject; w: DWord);
Const
 _cFuncName = 'jPanel_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setLParamHeight(env:PJNIEnv;this:jobject; Panel : jObject; h: DWord);
Const
 _cFuncName = 'jPanel_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jPanel_setLParamHeight2(env:PJNIEnv;this:jobject; Panel : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, Panel);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
end;
//by jmpessoa
function jPanel_getLParamHeight(env:PJNIEnv;this:jobject; Panel : jObject ): integer;
Const
 _cFuncName = 'jPanel_getLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := Panel;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

function jPanel_getLParamHeight2(env:PJNIEnv;this:jobject; Panel : jObject ): integer;
var
 _jMethod : jMethodID = nil;
 cls : jClass;
begin
 cls := env^.GetObjectClass(env, Panel);
_jMethod:= env^.GetMethodID(env, cls, 'getLParamHeight', '()I');
 Result:= env^.CallIntMethod(env,Panel,_jMethod);
end;

//by jmpessoa
function jPanel_getLParamWidth(env:PJNIEnv;this:jobject; Panel : jObject): integer;
Const
 _cFuncName = 'jPanel_getLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := Panel;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

function jPanel_getLParamWidth2(env:PJNIEnv;this:jobject; Panel : jObject): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
  cls := env^.GetObjectClass(env, Panel);
_jMethod:= env^.GetMethodID(env, cls, 'getLParamWidth', '()I');
 Result     := env^.CallIntMethod(env,Panel,_jMethod);
end;

//by jmpessoa
Procedure jPanel_resetLParamsRules(env:PJNIEnv;this:jobject; Panel : jObject);
Const
 _cFuncName = 'jPanel_resetLParamsRules';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jPanel_resetLParamsRules2(env:PJNIEnv;this:jobject; Panel : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
   cls := env^.GetObjectClass(env, Panel);
 _jMethod:= env^.GetMethodID(env, cls, 'resetLParamsRules', '()V');
 env^.CallVoidMethod(env,Panel,_jMethod);
end;

//by jmpessoa
Procedure jPanel_addLParamsParentRule(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);
Const
 _cFuncName = 'jPanel_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jPanel_addLParamsParentRule2(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := rule;
 cls := env^.GetObjectClass(env, Panel);
 _jMethod:= env^.GetMethodID(env, cls, 'addLParamsParentRule', '(I)V');
 env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_addLParamsAnchorRule(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);
Const
 _cFuncName = 'jPanel_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jPanel_addLParamsAnchorRule2(env:PJNIEnv;this:jobject; Panel : jObject; rule: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := rule;
 cls := env^.GetObjectClass(env, Panel);
 _jMethod:= env^.GetMethodID(env, cls, 'addLParamsAnchorRule', '(I)V');
 env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jPanel_setLayoutAll(env:PJNIEnv;this:jobject; Panel : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jPanel_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := Panel;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jPanel_setLayoutAll2(env:PJNIEnv;this:jobject; Panel : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, Panel);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,Panel,_jMethod,@_jParams);
end;

Procedure jPanel_RemoveParent(env:PJNIEnv;this:jobject; Panel : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, Panel);
_jMethod:= env^.GetMethodID(env, cls, 'RemoveParent', '()V');
 env^.CallVoidMethod(env,Panel,_jMethod);
end;

//------------------------------------------------------------------------------
// HorizontalScrollView
// LORDMAN 2013-09-03
//------------------------------------------------------------------------------
//
Function  jHorizontalScrollView_Create  (env:PJNIEnv;this:jobject;
                                         context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jHorizontalScrollView_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jHorizontalScrollView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jHorizontalScrollView_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;
//
Procedure jHorizontalScrollView_Free(env:PJNIEnv;this:jobject; ScrollView : jObject);
  Const
   _cFuncName = 'jHorizontalScrollView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ScrollView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ScrollView);
  end;

Procedure jHorizontalScrollView_Free2(env:PJNIEnv;this:jobject; ScrollView : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
   cls:= env^.GetObjectClass(env, ScrollView);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,ScrollView,_jMethod);
   env^.DeleteGlobalRef(env,ScrollView);
end;
//
Procedure jHorizontalScrollView_setXYWH(env:PJNIEnv;this:jobject;
                                        ScrollView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jHorizontalScrollView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jHorizontalScrollView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ScrollView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jHorizontalScrollView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jHorizontalScrollView_setParent(env:PJNIEnv;this:jobject;
                                          ScrollView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jHorizontalScrollView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

//
Procedure jHorizontalScrollView_setScrollSize(env:PJNIEnv;this:jobject;
                                              ScrollView : jObject; size : integer);
 Const
  _cFuncName = 'jHorizontalScrollView_setScrollSize';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ScrollView;
  _jParams[1].i := size;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jHorizontalScrollView_setScrollSize2(env:PJNIEnv;this:jobject;
                                              ScrollView : jObject; size : integer);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].i := size;
  cls := env^.GetObjectClass(env, ScrollView);
 _jMethod:= env^.GetMethodID(env, cls, 'setScrollSize', '(I)V');
  env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
 end;

//
Function jHorizontalScrollView_getView(env:PJNIEnv;this:jobject;
                                       ScrollView : jObject) : jObject;
 Const
  _cFuncName = 'jHorizontalScrollView_getView';
  _cFuncSig  = '(Ljava/lang/Object;)Landroid/view/ViewGroup;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l := ScrollView;
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 end;

//by jmpessoa
Procedure jHorizontalScrollView_setId(env:PJNIEnv;this:jobject; ScrollView : jObject; id: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jHorizontalScrollView_setMarginLeft(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_setMarginTop(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jHorizontalScrollView_setMarginRight(env:PJNIEnv;this:jobject; ScrollView : jObject; x: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_setMarginBottom(env:PJNIEnv;this:jobject; ScrollView : jObject; y: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_setLParamWidth2(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ScrollView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;

Procedure jHorizontalScrollView_setLParamWidth(env:PJNIEnv;this:jobject; ScrollView : jObject; w: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_setLParamHeight(env:PJNIEnv;this:jobject;
                                       ScrollView : jObject; h: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jHorizontalScrollView_setLParamHeight2(env:PJNIEnv;this:jobject;
                                       ScrollView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ScrollView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;
//by jmpessoa
Procedure jHorizontalScrollView_addLParamsParentRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ScrollView : jObject; rule: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jHorizontalScrollView_setLayoutAll(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jHorizontalScrollView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ScrollView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jHorizontalScrollView_setLayoutAll2(env:PJNIEnv;this:jobject; ScrollView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ScrollView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ScrollView,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// ViewFlipper
//------------------------------------------------------------------------------

// ViewFlipper
Function  jViewFlipper_Create(env:PJNIEnv;this:jobject;
                                        context : jObject; SelfObj : TObject ) : jObject;
Const
 _cFuncName = 'jViewFlipper_Create';
 _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := context;
 _jParams[1].j := Int64(SelfObj);
 Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
 Result := env^.NewGlobalRef(env,Result);
end;

//jmpessoa
function jViewFlipper_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jViewFlipper_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

Procedure jViewFlipper_Free            (env:PJNIEnv;this:jobject; ViewFlipper : jObject);
Const
 _cFuncName = 'jViewFlipper_Free';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := ViewFlipper;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteGlobalRef(env,ViewFlipper);
end;

Procedure jViewFlipper_Free2(env:PJNIEnv;this:jobject; ViewFlipper : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, ViewFlipper);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,ViewFlipper,_jMethod);
 env^.DeleteGlobalRef(env,ViewFlipper);
end;

//
Procedure jViewFlipper_setXYWH         (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;x,y,w,h : integer);
Const
 _cFuncName = 'jViewFlipper_setXYWH';
 _cFuncSig  = '(Ljava/lang/Object;IIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..4] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := x;
 _jParams[2].i := y;
 _jParams[3].i := w;
 _jParams[4].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jViewFlipper_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setParent       (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;ViewGroup : jObject);
Const
 _cFuncName = 'jViewFlipper_setParent';
 _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].l := ViewGroup;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setParent2       (env:PJNIEnv;this:jobject;
                                        ViewFlipper : jObject;ViewGroup : jObject);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := ViewGroup;
   cls := env^.GetObjectClass(env, ViewFlipper);
 _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
 env^.CallVoidMethodA(env,ViewFlipper,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setId(env:PJNIEnv;this:jobject; ViewFlipper : jObject; id: DWord);
Const
 _cFuncName = 'jViewFlipper_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setMarginLeft(env:PJNIEnv;this:jobject; ViewFlipper : jObject; x: DWord);
Const
 _cFuncName = 'jViewFlipper_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setMarginTop(env:PJNIEnv;this:jobject; ViewFlipper : jObject; y: DWord);
Const
 _cFuncName = 'jViewFlipper_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setMarginRight(env:PJNIEnv;this:jobject; ViewFlipper : jObject; x: DWord);
Const
 _cFuncName = 'jViewFlipper_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setMarginBottom(env:PJNIEnv;this:jobject; ViewFlipper : jObject; y: DWord);
Const
 _cFuncName = 'jViewFlipper_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setLParamWidth2(env:PJNIEnv;this:jobject; ViewFlipper : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ViewFlipper);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ViewFlipper,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setLParamWidth(env:PJNIEnv;this:jobject; ViewFlipper : jObject; w: DWord);
Const
 _cFuncName = 'jViewFlipper_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setLParamHeight(env:PJNIEnv;this:jobject; ViewFlipper : jObject; h: DWord);
Const
 _cFuncName = 'jViewFlipper_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setLParamHeight2(env:PJNIEnv;this:jobject; ViewFlipper : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ViewFlipper);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ViewFlipper,_jMethod,@_jParams);
end;
//by jmpessoa
Procedure jViewFlipper_addLParamsParentRule(env:PJNIEnv;this:jobject; ViewFlipper : jObject; rule: DWord);
Const
 _cFuncName = 'jViewFlipper_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ViewFlipper : jObject; rule: DWord);
Const
 _cFuncName = 'jViewFlipper_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jViewFlipper_setLayoutAll(env:PJNIEnv;this:jobject; ViewFlipper : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jViewFlipper_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ViewFlipper;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jViewFlipper_setLayoutAll2(env:PJNIEnv;this:jobject; ViewFlipper : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ViewFlipper);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ViewFlipper,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// WebView
//------------------------------------------------------------------------------

//
Function  jWebView_Create  (env:PJNIEnv;this:jobject;
                            context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jWebView_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jWebView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jWebView_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jWebView_Free   (env:PJNIEnv;this:jobject; WebView : jObject);
  Const
   _cFuncName = 'jWebView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := WebView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,WebView);
  end;

Procedure jWebView_Free2(env:PJNIEnv;this:jobject; WebView : jObject);
var
   _jMethod: jMethodID = nil;
   cls: jClass;
begin
   cls:= env^.GetObjectClass(env, WebView);
   _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
   env^.CallVoidMethod(env,WebView,_jMethod);
   env^.DeleteGlobalRef(env,WebView);
end;

//
Procedure jWebView_setXYWH(env:PJNIEnv;this:jobject;
                           WebView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jWebView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := WebView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jWebView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        WebView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jWebView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


//
Procedure jWebView_setParent(env:PJNIEnv;this:jobject;
                             WebView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jWebView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := WebView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jWebView_setParent2(env:PJNIEnv;this:jobject;
                             WebView : jObject;ViewGroup : jObject);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
   cls := env^.GetObjectClass(env, ViewGroup);
_jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,ViewGroup,_jMethod,@_jParams);
 end;

//
Procedure jWebView_setJavaScript       (env:PJNIEnv;this:jobject;
                                        WebView : jObject; javascript : boolean);
Const
 _cFuncName = 'jWebView_setJavaScript';
 _cFuncSig  = '(Ljava/lang/Object;Z)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].z := JBool(JavaScript);
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jWebView_setJavaScript2       (env:PJNIEnv;this:jobject;
                                        WebView : jObject; javascript : boolean);
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].z := JBool(JavaScript);
 cls := env^.GetObjectClass(env, WebView);
_jMethod:= env^.GetMethodID(env, cls, 'setJavaScript', '(Z)V');
 env^.CallVoidMethodA(env,WebView,_jMethod,@_jParams);
end;

//
Procedure jWebView_loadURL(env:PJNIEnv;this:jobject;
                           WebView : jObject; Str : String);
 Const
  _cFuncName = 'jWebView_loadURL';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := WebView;
  _jParams[1].l := env^.NewStringUTF(env, pchar(Str) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

//by jmpessoa
Procedure jWebView_loadURL2(env:PJNIEnv;this:jobject;
                           WebView : jObject; Str : String);
Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(Str) );
   cls := env^.GetObjectClass(env, WebView);
  _jMethod:= env^.GetMethodID(env, cls, 'loadURL2', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,WebView,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

//by jmpessoa
Procedure jWebView_setId(env:PJNIEnv;this:jobject; WebView : jObject; id: DWord);
Const
 _cFuncName = 'jWebView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jWebView_setMarginLeft(env:PJNIEnv;this:jobject; WebView: jObject; x: DWord);
Const
 _cFuncName = 'jWebView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_setMarginTop(env:PJNIEnv;this:jobject; WebView: jObject; y: DWord);
Const
 _cFuncName = 'jWebView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jWebView_setMarginRight(env:PJNIEnv;this:jobject; WebView: jObject; x: DWord);
Const
 _cFuncName = 'jWebView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_setMarginBottom(env:PJNIEnv;this:jobject; WebView: jObject; y: DWord);
Const
 _cFuncName = 'jWebView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_setLParamWidth2(env:PJNIEnv;this:jobject; WebView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, WebView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,WebView,_jMethod,@_jParams);
end;

Procedure jWebView_setLParamWidth(env:PJNIEnv;this:jobject; WebView : jObject; w: DWord);
Const
 _cFuncName = 'jWebView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_setLParamHeight(env:PJNIEnv;this:jobject; WebView : jObject; h: DWord);
Const
 _cFuncName = 'jWebView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jWebView_setLParamHeight2(env:PJNIEnv;this:jobject; WebView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, WebView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,WebView,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_addLParamsParentRule(env:PJNIEnv;this:jobject; WebView : jObject; rule: DWord);
Const
 _cFuncName = 'jWebView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; WebView : jObject; rule: DWord);
Const
 _cFuncName = 'jWebView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jWebView_setLayoutAll(env:PJNIEnv;this:jobject; WebView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jWebView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := WebView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jWebView_setLayoutAll2(env:PJNIEnv;this:jobject; WebView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, WebView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,WebView,_jMethod,@_jParams);
end;


//------------------------------------------------------------------------------
// Canvas
//------------------------------------------------------------------------------

Function jCanvas_Create(env:PJNIEnv;this:jobject;
                                        SelfObj : TObject) : jObject;
Const
 _cFuncName = 'jCanvas_Create';
 _cFuncSig  = '(J)Ljava/lang/Object;';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.j := Int64(SelfObj);
 Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 Result := env^.NewGlobalRef(env,Result);
end;

Procedure jCanvas_Free(env:PJNIEnv;this:jobject; jCanvas : jObject);
Const
 _cFuncName = 'jCanvas_Free';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := jCanvas;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteGlobalRef(env,jCanvas);
end;

Procedure jCanvas_Free2(env:PJNIEnv;this:jobject; jCanvas : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls:= env^.GetObjectClass(env, jCanvas);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,jCanvas,_jMethod);
 env^.DeleteGlobalRef(env,jCanvas);
end;

//
Procedure jCanvas_setStrokeWidth       (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject;width : single);
Const
 _cFuncName = 'jCanvas_setStrokeWidth';
 _cFuncSig  = '(Ljava/lang/Object;F)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].f := width;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_setStrokeWidth2(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject;width : single);
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].f:= width;
 cls := env^.GetObjectClass(env, jCanvas);
_jMethod:= env^.GetMethodID(env, cls, 'setStrokeWidth', '(F)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

Procedure jCanvas_setStyle             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; style : integer);
Const
 _cFuncName = 'jCanvas_setStyle';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].i := style;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_setStyle2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; style : integer);
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
  cls: jClass;
begin
 _jParams[0].i := style;
 cls := env^.GetObjectClass(env, jCanvas);
_jMethod:= env^.GetMethodID(env, cls, 'setStyle', '(I)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

Procedure jCanvas_setColor             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; color : DWord  );
Const
 _cFuncName = 'jCanvas_setColor';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].i := color;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_setColor2(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; color : DWord  );
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
   cls: jClass;
begin
 _jParams[0].i := color;
 cls := env^.GetObjectClass(env, jCanvas);
_jMethod:= env^.GetMethodID(env, cls, 'setColor', '(I)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;


Procedure jCanvas_setTextSize(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; textsize : single );
Const
 _cFuncName = 'jCanvas_setTextSize';
 _cFuncSig  = '(Ljava/lang/Object;F)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].f := textsize;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_setTextSize2(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; textsize : single );
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
    cls: jClass;
begin
 _jParams[0].f := textsize;
 cls := env^.GetObjectClass(env, jCanvas);
_jMethod:= env^.GetMethodID(env, cls, 'setTextSize', '(F)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

Procedure jCanvas_drawLine(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; x1,y1,x2,y2 : single);
Const
 _cFuncName = 'jCanvas_drawLine';
 _cFuncSig  = '(Ljava/lang/Object;FFFF)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..4] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].F := x1;
 _jParams[2].F := y1;
 _jParams[3].F := x2;
 _jParams[4].F := y2;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


Procedure jCanvas_drawLine2(env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; x1,y1,x2,y2 : single);
var
 _jMethod: jMethodID = nil;
 _jParams: Array[0..3] of jValue;
 cls: jClass;
begin
 _jParams[0].F := x1;
 _jParams[1].F := y1;
 _jParams[2].F := x2;
 _jParams[3].F := y2;
 cls := env^.GetObjectClass(env, jCanvas);
 _jMethod:= env^.GetMethodID(env, cls, 'drawLine', '(FFFF)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

// LORDMAN 2013-08-13
Procedure jCanvas_drawPoint(env:PJNIEnv;this:jobject; jCanvas:jObject; x1,y1:single);
Const
_cFuncName = 'jCanvas_drawPoint';
_cFuncSig  = '(Ljava/lang/Object;FF)V';
Var
_jMethod : jMethodID = nil;
_jParams : Array[0..2] of jValue;
begin
jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
_jParams[0].l := jCanvas;
_jParams[1].F := x1;
_jParams[2].F := y1;
env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_drawPoint2(env:PJNIEnv;this:jobject; jCanvas:jObject; x1,y1:single);
var
_jMethod : jMethodID = nil;
_jParams : Array[0..1] of jValue;
cls: jClass;
begin
_jParams[0].F := x1;
_jParams[1].F := y1;
cls := env^.GetObjectClass(env, jCanvas);
_jMethod:= env^.GetMethodID(env, cls, 'drawPoint', '(FF)V');
env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

Procedure jCanvas_drawText             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; const text : string; x,y : single);
Const
 _cFuncName = 'jCanvas_drawText';
 _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;FF)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..3] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].l := env^.NewStringUTF(env, pchar(text) );
 _jParams[2].F := x;
 _jParams[3].F := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

Procedure jCanvas_drawText2             (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; const text : string; x,y : single);
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..2] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(text) );
 _jParams[1].F := x;
 _jParams[2].F := y;
 cls := env^.GetObjectClass(env, jCanvas);

 _jMethod:= env^.GetMethodID(env, cls, 'drawText', '(Ljava/lang/String;FF)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;


Procedure jCanvas_drawBitmap           (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; bmp : jObject; b,l,r,t : integer);
Const
 _cFuncName = 'jCanvas_drawBitmap';
 _cFuncSig  = '(Ljava/lang/Object;Landroid/graphics/Bitmap;IIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..5] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := jCanvas;
 _jParams[1].l := bmp;
 _jParams[2].i := b;
 _jParams[3].i := l;
 _jParams[4].i := r;
 _jParams[5].i := t;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jCanvas_drawBitmap2           (env:PJNIEnv;this:jobject;
                                        jCanvas : jObject; bmp : jObject; b,l,r,t : integer);
var
 _jMethod: jMethodID = nil;
 _jParams: Array[0..4] of jValue;
 cls: jClass;
begin
 _jParams[0].l := bmp;
 _jParams[1].i := b;
 _jParams[2].i := l;
 _jParams[3].i := r;
 _jParams[4].i := t;
 cls:= env^.GetObjectClass(env, jCanvas);

 _jMethod:= env^.GetMethodID(env, cls, 'drawBitmap', '(Landroid/graphics/Bitmap;IIII)V');
 env^.CallVoidMethodA(env,jCanvas,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// Bitmap
//------------------------------------------------------------------------------

//
Function  jBitmap_Create  (env:PJNIEnv;this:jobject;
                           SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jBitmap_Create';
  _cFuncSig  = '(J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
  Result := env^.NewGlobalRef(env,Result);
 end;

//
Procedure jBitmap_Free   (env:PJNIEnv;this:jobject; jbitmap : jObject);
  Const
   _cFuncName = 'jBitmap_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParam  : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParam.l := jbitmap;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
   env^.DeleteGlobalRef(env,jbitmap);
  end;

Procedure jBitmap_Free2   (env:PJNIEnv;this:jobject; jbitmap : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,jbitmap,_jMethod);
  env^.DeleteGlobalRef(env,jbitmap);
end;

//
Procedure jBitmap_loadFile(env:PJNIEnv;this:jobject;
                           jbitmap : jObject; filename : String);
 Const
  _cFuncName = 'jBitmap_loadFile';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := jbitmap;
  _jParams[1].l := env^.NewStringUTF(env, pchar(filename) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;


Procedure jBitmap_loadFile2(env:PJNIEnv;this:jobject;
                           jbitmap : jObject; filename : String);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(filename) );
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls, 'loadFile', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,jbitmap,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//by jmpessoa
Procedure jBitmap_loadRes(env:PJNIEnv;this:jobject;
                           jbitmap : jObject; imgResIdentifier : String);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(imgResIdentifier) );
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls, 'loadRes', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,jbitmap,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//
Procedure jBitmap_createBitmap(env:PJNIEnv;this:jobject;
                               jbitmap : jObject; w,h : integer);
 Const
  _cFuncName = 'jBitmap_createBitmap';
  _cFuncSig  = '(Ljava/lang/Object;II)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..2] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := jbitmap;
  _jParams[1].i := w;
  _jParams[2].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jBitmap_createBitmap2(env:PJNIEnv;this:jobject;
                               jbitmap : jObject; w,h : integer);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
  cls: jClass;
begin
  _jParams[0].i:= w;
  _jParams[1].i:= h;
  cls := env^.GetObjectClass(env, jbitmap);
   _jMethod:= env^.GetMethodID(env, cls, 'createBitmap', '(II)V');
  env^.CallVoidMethodA(env,jbitmap,_jMethod,@_jParams);
end;

//
Procedure jBitmap_getWH(env:PJNIEnv;this:jobject;
                        jbitmap : jObject; var w,h : integer);
 Const
  _cFuncName = 'jBitmap_getWH';
  _cFuncSig  = '(Ljava/lang/Object;)[I';
 Var
  _jMethod   : jMethodID = nil;
  _jParam    : jValue;
  _jIntArray : jintArray;
  _jBoolean  : jBoolean;
  //
  PInt       : PInteger;
  PIntSav    : PInteger;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l  := jbitmap;
  _jIntArray := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
  //
  _jBoolean  := JNI_False;
  PInt       := env^.GetIntArrayElements(env,_jIntArray,_jBoolean);
  PIntSav    := PInt;
  w          := PInt^; Inc(PInt);
  h          := PInt^; Inc(PInt);
  env^.ReleaseIntArrayElements(env,_jIntArray,PIntSav,0);
 end;

Procedure jBitmap_getWH2(env:PJNIEnv;this:jobject;
                        jbitmap : jObject; var w,h : integer);
var
  _jMethod   : jMethodID = nil;
  _jIntArray : jintArray;
  _jBoolean  : jBoolean;
  //
  PInt       : PInteger;
  PIntSav    : PInteger;
  cls: jClass;
 begin
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls, 'getWH', '()[I');
  _jIntArray := env^.CallObjectMethod(env,jbitmap,_jMethod);
  //
  _jBoolean  := JNI_False;
  PInt       := env^.GetIntArrayElements(env,_jIntArray,_jBoolean);
  PIntSav    := PInt;
  w          := PInt^; Inc(PInt);
  h          := PInt^; Inc(PInt);
  env^.ReleaseIntArrayElements(env,_jIntArray,PIntSav,0);
 end;

Function  jBitmap_jInstance(env:PJNIEnv;this:jobject;
                                 jbitmap : jObject) : jObject;
Const
 _cFuncName = 'jBitmap_jInstance';
 _cFuncSig  = '(Ljava/lang/Object;)Landroid/graphics/Bitmap;';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l := jbitmap;
 Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
end;
//by jmpessoa
function jBitmap_GetWidth(env: PJNIEnv; this: JObject; _jbitmap: JObject): integer;
var
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jCls:= env^.GetObjectClass(env, _jbitmap);
  jMethod:= env^.GetMethodID(env, jCls, 'GetWidth', '()I');
  Result:= env^.CallIntMethod(env, _jbitmap, jMethod);
end;

//by jmpessoa
function jBitmap_GetHeight(env: PJNIEnv; this: JObject; _jbitmap: JObject): integer;
var
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jCls:= env^.GetObjectClass(env, _jbitmap);
  jMethod:= env^.GetMethodID(env, jCls, 'GetHeight', '()I');
  Result:= env^.CallIntMethod(env, _jbitmap, jMethod);
end;

//by jmpessoa
Function  jBitmap_jInstance2(env:PJNIEnv;this:jobject; jbitmap: jObject): jObject;
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls,'jInstance', '()Landroid/graphics/Bitmap;');
  Result := env^.CallObjectMethod(env,jbitmap,_jMethod);
end;

//by jmpessoa
procedure jBitmap_SetByteArrayToBitmap(env:PJNIEnv; this:jobject; jbitmap: jObject; var bufferImage: TArrayOfByte; size: integer);
var
  _jMethod: jMethodID = nil;
  cls: jClass;
  _jParam: array[0..0] of jValue;
  _jbyteArray : jByteArray;
begin
   //Convert the Pascal's Native array[] of jbyte to JNI jbytearray
  _jbyteArray:= env^.NewByteArray(env, size);  // allocate
  env^.SetByteArrayRegion(env, _jbyteArray, 0 , size, @bufferImage[0] {source});  // copy
  _jParam[0].l:= _jbyteArray;
  cls := env^.GetObjectClass(env, jbitmap);
  _jMethod:= env^.GetMethodID(env, cls, 'SetByteArrayToBitmap', '([B)V');
  env^.CallVoidMethodA(env,jbitmap,_jMethod, @_jParam);
  env^.DeleteLocalRef(env,_jParam[0].l);
end;

//by jmpessoa
function jBitmap_GetByteArrayFromBitmap(env:PJNIEnv; this:jobject; jbitmap: jObject;  var bufferImage: TArrayOfByte): integer;
var
  _jMethod: jMethodID = nil;
  _jbyteArray: jbyteArray;
  cls: jClass;
begin
 cls := env^.GetObjectClass(env, jbitmap);
 _jMethod:= env^.GetMethodID(env, cls, 'GetByteArrayFromBitmap', '()[B');
  _jbyteArray := env^.CallObjectMethod(env,jbitmap,_jMethod);
  Result:= env^.GetArrayLength(env,_jbyteArray);
  SetLength(bufferImage, Result);
  env^.GetByteArrayRegion(env, _jbyteArray, 0, Result, @bufferImage[0] {target});
end;


//------------------------------------------------------------------------------
// jGLSurfaceView
//------------------------------------------------------------------------------

Function  jGLSurfaceView_Create(env:PJNIEnv;this:jobject; 
                                context : jObject; SelfObj : TObject; version : integer) : jObject;
 Const
  _cFuncName = 'jGLSurfaceView_Create';
  _cFuncSig  = '(Landroid/content/Context;JI)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..2] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  _jParams[2].i := version;
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jGLSurfaceView_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject; version : integer): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jGLSurfaceView_Create2', '(JI)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  _jParams[1].i := version;
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jGLSurfaceView_Free   (env:PJNIEnv;this:jobject; GLSurfaceView : jObject);
  Const
   _cFuncName = 'jGLSurfaceView_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := GLSurfaceView;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,GLSurfaceView);
  end;

Procedure jGLSurfaceView_Free2   (env:PJNIEnv;this:jobject; GLSurfaceView : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, GLSurfaceView);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,GLSurfaceView,_jMethod);
  env^.DeleteGlobalRef(env,GLSurfaceView);
end;

// 
Procedure jGLSurfaceView_setXYWH(env:PJNIEnv;this:jobject;
                                 GLSurfaceView : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jGLSurfaceView_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := GLSurfaceView;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jGLSurfaceView_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        GLSurfaceView : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jGLSurfaceView_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

// 
Procedure jGLSurfaceView_setParent(env:PJNIEnv;this:jobject;
                                   GLSurfaceView : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jGLSurfaceView_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := GLSurfaceView;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jGLSurfaceView_setParent2(env:PJNIEnv;this:jobject;
                                   GLSurfaceView : jObject;ViewGroup : jObject);
 var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := ViewGroup;
  cls := env^.GetObjectClass(env, GLSurfaceView);
  _jMethod:= env^.GetMethodID(env, cls, 'setParent', '(Landroid/view/ViewGroup;)V');
  env^.CallVoidMethodA(env,GLSurfaceView,_jMethod,@_jParams);
 end;
 
Procedure jGLSurfaceView_SetAutoRefresh(env:PJNIEnv;this:jobject; glView : jObject; Active : Boolean);
 Const
  _cFuncName = 'jGLSurfaceView_SetAutoRefresh';
  _cFuncSig  = '(Ljava/lang/Object;Z)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := glView;
  _jParams[1].z := JBool(Active);
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jGLSurfaceView_SetAutoRefresh2(env:PJNIEnv;this:jobject; glView : jObject; Active : Boolean);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  _jParams[0].z := JBool(Active);
  cls := env^.GetObjectClass(env, glView);
   _jMethod:= env^.GetMethodID(env, cls, 'SetAutoRefresh', '(Z)V');
  env^.CallVoidMethodA(env,glView,_jMethod,@_jParams);
end;

procedure jGLSurfaceView_Refresh(env: PJNIEnv; this: jobject; glView: jObject);
const
  _cFuncName = 'jGLSurfaceView_Refresh';
  _cFuncSig  = '(Ljava/lang/Object;)V';
var
  _jMethod: jMethodID = nil;
  _jParam: jValue;
begin
  gVM^.AttachCurrentThread(gVm,@env,nil); //<<-- (un)commented by by jmpessoa
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l:= glView;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
end;

//by jmpessoa
procedure jGLSurfaceView_Refresh2(env:PJNIEnv;this:jobject; glView : jObject);
var
  _jMethod: jMethodID = nil;
  cls: jClass;
begin
  gVM^.AttachCurrentThread(gVm,@env,nil); //<<-- (un)commented by by jmpessoa
  cls:= env^.GetObjectClass(env, glView);
  _jMethod:= env^.GetMethodID(env, cls, 'Refresh', '()V');
  env^.CallVoidMethod(env,glView,_jMethod);
end;

Procedure jGLSurfaceView_deleteTexture(env:PJNIEnv;this:jobject; glView : jObject; id : Integer);
 Const
  _cFuncName = 'jGLSurfaceView_deleteTexture';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
 begin
  gVM^.AttachCurrentThread(gVm,@env,nil);
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := glView;
  _jParams[1].i := id;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

procedure jGLSurfaceView_deleteTexture2(env:PJNIEnv;this:jobject; glView : jObject; id : Integer);
var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..0] of jValue;
  cls: jClass;
begin
  gVM^.AttachCurrentThread(gVm,@env,nil);
  _jParams[0].i := id;
  cls := env^.GetObjectClass(env, glView);
  _jMethod:= env^.GetMethodID(env, cls, 'deleteTexture', '(I)V');
  env^.CallVoidMethodA(env,glView,_jMethod,@_jParams);
end;


Procedure jGLSurfaceView_getBmpArray(env:PJNIEnv;this:jobject;filename : String);
 Const
  _cFuncName = 'getBmpArray';
  _cFuncSig  = '(Ljava/lang/String;)[I';
 Var
  _jMethod   : jMethodID = nil;
  _jParam    : jValue;
  _jIntArray : jintArray;
  _jBoolean  : jBoolean;
  //
  Size : Integer;
  PInt : PInteger;
  PIntS: PInteger;
 // i    : Integer;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l  := env^.NewStringUTF( env, pchar(filename));
  _jIntArray := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
  env^.DeleteLocalRef(env,_jParam.l);
  Size := env^.GetArrayLength(env,_jIntArray);
  dbg('Size: ' + IntToStr(Size) );
  _jBoolean  := JNI_False;
  PInt := env^.GetIntArrayElements(env,_jIntArray,_jBoolean);
  PIntS:= PInt;
  Inc(PIntS,Size-2);
  dbg('width:'  + IntToStr(PintS^)); Inc(PintS);
  dbg('height:' + IntToStr(PintS^));
  env^.ReleaseIntArrayElements(env,_jIntArray,PInt,0);
  dbg('Here...');
 end;

Procedure jGLSurfaceView_requestGLThread(env:PJNIEnv;this:jobject; glView : jObject);
 Const
  _cFuncName = 'jGLSurfaceView_glThread';
  _cFuncSig  = '(Ljava/lang/Object;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  gVM^.AttachCurrentThread(gVm,@env,nil);
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l := glView;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
 end;

//by jmpessoa
Procedure jGLSurfaceView_requestGLThread2(env: PJNIEnv;this:jobject; glView : jObject);
var
  _jMethod : jMethodID = nil;
   cls: jClass;
begin
  gVM^.AttachCurrentThread(gVm,@env,nil);
  cls := env^.GetObjectClass(env, glView);
   _jMethod:= env^.GetMethodID(env, cls, 'glThread', '()V');
  env^.CallVoidMethod(env,glView,_jMethod);
end;

//by jmpessoa
Procedure jGLSurfaceView_setId(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; id: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jGLSurfaceView_setMarginLeft(env:PJNIEnv;this:jobject; GLSurfaceView: jObject; x: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_setMarginTop(env:PJNIEnv;this:jobject; GLSurfaceView: jObject; y: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;
Procedure jGLSurfaceView_setMarginRight(env:PJNIEnv;this:jobject; GLSurfaceView: jObject; x: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_setMarginBottom(env:PJNIEnv;this:jobject; GLSurfaceView: jObject; y: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_setLParamWidth2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, GLSurfaceView);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,GLSurfaceView,_jMethod,@_jParams);
end;

Procedure jGLSurfaceView_setLParamWidth(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; w: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_setLParamHeight(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; h: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jGLSurfaceView_setLParamHeight2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, GLSurfaceView);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,GLSurfaceView,_jMethod,@_jParams);
end;
//by jmpessoa
function jGLSurfaceView_getLParamHeight(env:PJNIEnv;this:jobject; GLSurfaceView : jObject ): integer;
Const
 _cFuncName = 'jGLSurfaceView_getLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := GLSurfaceView;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

function jGLSurfaceView_getLParamHeight2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject ): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, GLSurfaceView);
  _jMethod:= env^.GetMethodID(env, cls, 'getLParamHeight', '()I');
 Result:= env^.CallIntMethod(env,GLSurfaceView,_jMethod);
end;

function jGLSurfaceView_getLParamWidth(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;
Const
 _cFuncName = 'jGLSurfaceView_getLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l := GLSurfaceView;
 Result     := env^.CallIntMethodA(env,this,_jMethod,@_jParams);
end;

function jGLSurfaceView_getLParamWidth2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, GLSurfaceView);
  _jMethod:= env^.GetMethodID(env, cls, 'getLParamWidth', '()I');
 Result:= env^.CallIntMethod(env,GLSurfaceView,_jMethod);
end;

//by jmpessoa
Procedure jGLSurfaceView_addLParamsParentRule(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; rule: DWord);
Const
 _cFuncName = 'jGLSurfaceView_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_addLParamsAnchorRule(env:PJNIEnv;this:jobject; GLSurfaceView : jObject; rule: DWord);
Const
 _cFuncName = 'jGLSurfaceView_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jGLSurfaceView_setLayoutAll(env:PJNIEnv;this:jobject; GLSurfaceView : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jGLSurfaceView_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := GLSurfaceView;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jGLSurfaceView_setLayoutAll2(env:PJNIEnv;this:jobject; GLSurfaceView : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, GLSurfaceView);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,GLSurfaceView,_jMethod,@_jParams);
end;
//------------------------------------------------------------------------------
// Timer
//------------------------------------------------------------------------------

Function jTimer_Create (env:PJNIEnv;this:jobject; SelfObj : TObject): jObject;
 Const
  _cFuncName = 'jTimer_Create';
  _cFuncSig  = '(J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.j := Int64(SelfObj);
  Result    := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
  Result    := env^.NewGlobalRef(env,Result);
 end;

//
Procedure jTimer_Free(env:PJNIEnv;this:jobject; Timer : jObject);
  Const
   _cFuncName = 'jTimer_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := Timer;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,Timer);
  end;

Procedure jTimer_Free2(env:PJNIEnv;this:jobject; Timer : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
 cls := env^.GetObjectClass(env, Timer);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,Timer,_jMethod);
 env^.DeleteGlobalRef(env,Timer);
end;

Procedure jTimer_SetInterval(env:PJNIEnv;this:jobject; Timer  : jObject; Interval : Integer);
const
  _cFuncName = 'jTimer_SetInterval';
  _cFuncSig  = '(Ljava/lang/Object;I)V';
var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Timer;
  _jParams[1].i := Interval;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jTimer_SetInterval2(env:PJNIEnv;this:jobject; Timer  : jObject; Interval : Integer);
var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..0] of jValue;
   cls: jClass;
begin
  _jParams[0].i:= Interval;
  cls := env^.GetObjectClass(env, Timer);
  _jMethod:= env^.GetMethodID(env, cls, 'SetInterval', '(I)V');
  env^.CallVoidMethodA(env,Timer,_jMethod,@_jParams);
end;

Procedure jTimer_SetEnabled (env:PJNIEnv;this:jobject; Timer  : jObject; Active : Boolean);
 Const
  _cFuncName = 'jTimer_SetEnabled';
  _cFuncSig  = '(Ljava/lang/Object;Z)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := Timer;
  _jParams[1].z := JBool(Active);
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

//by jmpessoa
Procedure jTimer_SetEnabled2(env: PJNIEnv; this: jobject; Timer: jObject; Active: Boolean);
var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..0] of jValue;
   cls: jClass;
begin
  _jParams[0].z := JBool(Active);
  cls := env^.GetObjectClass(env, Timer);
  _jMethod:= env^.GetMethodID(env, cls, 'SetEnabled', '(Z)V');
  env^.CallVoidMethodA(env,Timer,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// jDialog YN
//------------------------------------------------------------------------------

Function jDialogYN_Create (env:PJNIEnv;this:jobject; SelfObj : TObject;
                           title,msg,y,n : string ): jObject;
 Const
  _cFuncName = 'jDialogYN_Create';
  _cFuncSig  = '(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].j := Int64(SelfObj);
  _jParams[1].l := env^.NewStringUTF(env, pchar(title) );
  _jParams[2].l := env^.NewStringUTF(env, pchar(Msg  ) );
  _jParams[3].l := env^.NewStringUTF(env, pchar(y    ) );
  _jParams[4].l := env^.NewStringUTF(env, pchar(n    ) );
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[2].l);
  env^.DeleteLocalRef(env,_jParams[3].l);
  env^.DeleteLocalRef(env,_jParams[4].l);
 end;

//
Procedure jDialogYN_Free   (env:PJNIEnv;this:jobject; DialogYN : jObject);
  Const
   _cFuncName = 'jDialogYN_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := DialogYN;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,DialogYN);
  end;

Procedure jDialogYN_Free2   (env:PJNIEnv;this:jobject; DialogYN : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, DialogYN);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,DialogYN,_jMethod);
  env^.DeleteGlobalRef(env,DialogYN);
end;

Procedure jDialogYN_Show (env:PJNIEnv;this:jobject; DialogYN: jObject);
Const
 _cFuncName = 'jDialogYN_Show';
 _cFuncSig  = '(Ljava/lang/Object;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l := DialogYN;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
end;

Procedure jDialogYN_Show2(env:PJNIEnv;this:jobject; DialogYN: jObject);
var
 _jMethod: jMethodID = nil;
 _jParam: jValue;
 cls: jClass;
begin
 cls:= env^.GetObjectClass(env, DialogYN);
 _jMethod:= env^.GetMethodID(env, cls, 'show', '()V');
 env^.CallVoidMethodA(env,DialogYN,_jMethod,@_jParam);
end;

//------------------------------------------------------------------------------
// jDialog Progress
//------------------------------------------------------------------------------

Function jDialogProgress_Create(env:PJNIEnv;this:jobject; SelfObj : TObject;
                                 title, msg: string ): jObject;
 Const
  _cFuncName = 'jDialogProgress_Create';
  _cFuncSig  = '(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..2] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].j := Int64(SelfObj);
  _jParams[1].l := env^.NewStringUTF(env, pchar(title) );
  _jParams[2].l := env^.NewStringUTF(env, pchar(Msg  ) );
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[2].l);
 end;

//
Procedure jDialogProgress_Free (env:PJNIEnv;this:jobject; DialogProgress : jObject);
 Const
  _cFuncName = 'jDialogProgress_Free';
  _cFuncSig  = '(Ljava/lang/Object;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.l  := DialogProgress;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
  env^.DeleteGlobalRef(env,DialogProgress);
 end;


Procedure jDialogProgress_Free2 (env:PJNIEnv;this:jobject; DialogProgress : jObject);
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls:= env^.GetObjectClass(env, DialogProgress);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,DialogProgress,_jMethod);
  env^.DeleteGlobalRef(env,DialogProgress);
end;

//------------------------------------------------------------------------------
// MessageBox , Dialog
//------------------------------------------------------------------------------

Procedure jToast (env:PJNIEnv;this:jobject; Str : String);
 Const
  _cFuncName = 'jToast';
  _cFuncSig  = '(Ljava/lang/String;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l := env^.NewStringUTF(env, pchar(Str) );
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
 env^.DeleteLocalRef(env,_jParam.l);
end;

//------------------------------------------------------------------------------
// jImageBtn
//------------------------------------------------------------------------------

//
Function  jImageBtn_Create  (env:PJNIEnv;this:jobject;
                              context : jObject; SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jImageBtn_Create';
  _cFuncSig  = '(Landroid/content/Context;J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := context;
  _jParams[1].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jImageBtn_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jImageBtn_Create2', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jImageBtn_Free   (env:PJNIEnv;this:jobject; ImageBtn : jObject);
  Const
   _cFuncName = 'jImageBtn_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := ImageBtn;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,ImageBtn);
  end;

Procedure jImageBtn_Free2   (env:PJNIEnv;this:jobject; ImageBtn : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
 cls := env^.GetObjectClass(env, ImageBtn);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,ImageBtn,_jMethod);
 env^.DeleteGlobalRef(env,ImageBtn);
end;

//
Procedure jImageBtn_setXYWH(env:PJNIEnv;this:jobject;
                            ImageBtn : jObject;x,y,w,h : integer);
 Const
  _cFuncName = 'jImageBtn_setXYWH';
  _cFuncSig  = '(Ljava/lang/Object;IIII)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..4] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageBtn;
  _jParams[1].i := x;
  _jParams[2].i := y;
  _jParams[3].i := w;
  _jParams[4].i := h;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

Procedure jImageBtn_setLeftTopRightBottomWidthHeight(env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; ml,mt,mr,mb,w,h: integer);
Const
 _cFuncName = 'jImageBtn_setLeftTopRightBottomWidthHeight';
 _cFuncSig  = '(Ljava/lang/Object;IIIIII)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..6] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := ml;
 _jParams[2].i := mt;
 _jParams[3].i := mr;
 _jParams[4].i := mb;
 _jParams[5].i := w;
 _jParams[6].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//
Procedure jImageBtn_setParent(env:PJNIEnv;this:jobject;
                               ImageBtn : jObject;ViewGroup : jObject);
 Const
  _cFuncName = 'jImageBtn_setParent';
  _cFuncSig  = '(Ljava/lang/Object;Landroid/view/ViewGroup;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageBtn;
  _jParams[1].l := ViewGroup;
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end;

//
Procedure jImageBtn_setButton(env:PJNIEnv;this:jobject;
                              ImageBtn: jObject; up,dn : string);
 Const
  _cFuncName = 'jImageBtn_setButton';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..2] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageBtn;
  _jParams[1].l := env^.NewStringUTF(env, pchar(up) );
  _jParams[2].l := env^.NewStringUTF(env, pchar(dn) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[2].l);
 end;

 //by jmpessoa
Procedure jImageBtn_setButtonUp(env:PJNIEnv;this:jobject;
                              ImageBtn: jObject; up: string);
 Const
  _cFuncName = 'jImageBtn_setButtonUp';
  _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageBtn;
  _jParams[1].l := env^.NewStringUTF(env, pchar(up) );
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[1].l);
 end;

Procedure jImageBtn_setButtonUp2(env:PJNIEnv;this:jobject;
                              ImageBtn: jObject; up: string);
var
  _jMethod : jMethodID = nil;
  _jParams : array[0..0] of jValue;
  cls: jClass;
 begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(up) );
   cls := env^.GetObjectClass(env, ImageBtn);
 _jMethod:= env^.GetMethodID(env, cls, 'setButtonUp', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
 end;

//by jmpessoa
Procedure jImageBtn_setButtonDown(env:PJNIEnv;this:jobject;
                             ImageBtn: jObject; dn: string);
Const
 _cFuncName = 'jImageBtn_setButtonDown';
 _cFuncSig  = '(Ljava/lang/Object;Ljava/lang/String;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].l := env^.NewStringUTF(env, pchar(dn) );
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

Procedure jImageBtn_setButtonDown2(env:PJNIEnv;this:jobject;
                             ImageBtn: jObject; dn: string);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(dn) );
  cls := env^.GetObjectClass(env, ImageBtn);
_jMethod:= env^.GetMethodID(env, cls, 'setButtonDown', '(Ljava/lang/String;)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jImageBtn_setButtonDownByRes(env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; imgResIdentifief: String);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(imgResIdentifief) );
  cls := env^.GetObjectClass(env, ImageBtn);
_jMethod:= env^.GetMethodID(env, cls, 'setButtonDownByRes', '(Ljava/lang/String;)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jImageBtn_setButtonUpByRes(env:PJNIEnv;this:jobject;
                                        ImageBtn : jObject; imgResIdentifief: String);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].l := env^.NewStringUTF(env, pchar(imgResIdentifief) );
  cls := env^.GetObjectClass(env, ImageBtn);
_jMethod:= env^.GetMethodID(env, cls, 'setButtonUpByRes', '(Ljava/lang/String;)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
end;


// LORDMAN 2013-08-16
Procedure jImageBtn_SetEnabled (env:PJNIEnv;this:jobject; 
                                ImageBtn : jObject; Active   : Boolean);
 Const
  _cFuncName = 'jImageBtn_setEnabled';
  _cFuncSig  = '(Ljava/lang/Object;Z)V';
 Var
  _jMethod : jMethodID = nil;
  _jParams : Array[0..1] of jValue;
 begin
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParams[0].l := ImageBtn;
  _jParams[1].z := JBool(Active);
  env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 end; 

//by jmpessoa
Procedure jImageBtn_setId(env:PJNIEnv;this:jobject; ImageBtn : jObject; id: DWord);
Const
 _cFuncName = 'jImageBtn_setId';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := id;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jImageBtn_setMarginLeft(env:PJNIEnv;this:jobject; ImageBtn: jObject; x: DWord);
Const
 _cFuncName = 'jImageBtn_setMarginLeft';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_setMarginTop(env:PJNIEnv;this:jobject; ImageBtn: jObject; y: DWord);
Const
 _cFuncName = 'jImageBtn_setMarginTop';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;
Procedure jImageBtn_setMarginRight(env:PJNIEnv;this:jobject; ImageBtn: jObject; x: DWord);
Const
 _cFuncName = 'jImageBtn_setMarginRight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := x;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_setMarginBottom(env:PJNIEnv;this:jobject; ImageBtn: jObject; y: DWord);
Const
 _cFuncName = 'jImageBtn_setMarginBottom';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := y;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_setLParamWidth2(env:PJNIEnv;this:jobject; ImageBtn : jObject; w: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := w;
 cls := env^.GetObjectClass(env, ImageBtn);
  _jMethod:= env^.GetMethodID(env, cls, 'setLParamWidth', '(I)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
end;

Procedure jImageBtn_setLParamWidth(env:PJNIEnv;this:jobject; ImageBtn : jObject; w: DWord);
Const
 _cFuncName = 'jImageBtn_setLParamWidth';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := w;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_setLParamHeight(env:PJNIEnv;this:jobject; ImageBtn : jObject; h: DWord);
Const
 _cFuncName = 'jImageBtn_setLParamHeight';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := h;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jImageBtn_setLParamHeight2(env:PJNIEnv;this:jobject; ImageBtn : jObject; h: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := h;
  cls := env^.GetObjectClass(env, ImageBtn);
_jMethod:= env^.GetMethodID(env, cls, 'setLParamHeight', '(I)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_addLParamsParentRule(env:PJNIEnv;this:jobject; ImageBtn : jObject; rule: DWord);
Const
 _cFuncName = 'jImageBtn_addLParamsParentRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_addLParamsAnchorRule(env:PJNIEnv;this:jobject; ImageBtn : jObject; rule: DWord);
Const
 _cFuncName = 'jImageBtn_addLParamsAnchorRule';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := rule;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jImageBtn_setLayoutAll(env:PJNIEnv;this:jobject; ImageBtn : jObject;  idAnchor: DWord);
Const
 _cFuncName = 'jImageBtn_setLayoutAll';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := ImageBtn;
 _jParams[1].i := idAnchor;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jImageBtn_setLayoutAll2(env:PJNIEnv;this:jobject; ImageBtn : jObject;  idAnchor: DWord);
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
 _jParams[0].i := idAnchor;
 cls := env^.GetObjectClass(env, ImageBtn);
_jMethod:= env^.GetMethodID(env, cls, 'setLayoutAll', '(I)V');
 env^.CallVoidMethodA(env,ImageBtn,_jMethod,@_jParams);
end;

//------------------------------------------------------------------------------
// jAsyncTask
//------------------------------------------------------------------------------

//

Function  jAsyncTask_Create(env:PJNIEnv;this:jobject;
                              SelfObj : TObject) : jObject;
 Const
  _cFuncName = 'jAsyncTask_Create';
  _cFuncSig  = '(J)Ljava/lang/Object;';
 Var
  _jMethod : jMethodID = nil;
  _jParam  : jValue;
 begin
  //dbg('jAsyncTask_Create env:'+IntTostr(integer(env)));
  jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
  _jParam.j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
  Result := env^.NewGlobalRef(env,Result);
 end;

//by jmpessoa
function jAsyncTask_Create2(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env); {global}          {warning: a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jAsyncTask_Create', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

//
Procedure jAsyncTask_Free   (env:PJNIEnv;this:jobject; AsyncTask : jObject);
  Const
   _cFuncName = 'jAsyncTask_Free';
   _cFuncSig  = '(Ljava/lang/Object;)V';
  Var
   _jMethod : jMethodID = nil;
   _jParams : jValue;
  begin
   //dbg('jAsyncTask_Free env:'+IntTostr(integer(env)));
   jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
   _jParams.l := AsyncTask;
   env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
   env^.DeleteGlobalRef(env,AsyncTask);
  end;

Procedure jAsyncTask_Free2   (env:PJNIEnv;this:jobject; AsyncTask : jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, AsyncTask);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env,AsyncTask,_jMethod);
  env^.DeleteGlobalRef(env,AsyncTask);
end;

//
procedure jAsyncTask_Execute(env:PJNIEnv;this:jobject; AsyncTask : jObject);
const
 _cFuncName = 'jAsyncTask_Execute';
 _cFuncSig  = '(Ljava/lang/Object;)V';
var
 _jMethod : jMethodID = nil;
 _jParams : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams.l:= AsyncTask;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;


procedure jAsyncTask_Execute2(env:PJNIEnv;this:jobject; AsyncTask : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
  cls := env^.GetObjectClass(env, AsyncTask);
  _jMethod:= env^.GetMethodID(env, cls, 'Execute2', '()V');
 env^.CallVoidMethod(env,AsyncTask,_jMethod);
end;

//
Procedure jAsyncTask_setProgress(env:PJNIEnv;this:jobject; AsyncTask : jObject;Progress : Integer);
const
 _cFuncName = 'jAsyncTask_setProgress';
 _cFuncSig  = '(Ljava/lang/Object;I)V';
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..1] of jValue;
begin
 //dbg('jAsyncTask_setProgress env:'+IntTostr(integer(env)));
 gVM^.AttachCurrentThread(gVm,@env,nil);
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := AsyncTask;
 _jParams[1].i := progress;
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
end;

Procedure jAsyncTask_setProgress2(env:PJNIEnv;this:jobject; AsyncTask : jObject; Progress : Integer);
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
  cls: jClass;
begin
 //dbg('jAsyncTask_setProgress env:'+IntTostr(integer(env)));
 _jParams[0].i := progress;
  cls := env^.GetObjectClass(env, AsyncTask);
  _jMethod:= env^.GetMethodID(env, cls, 'setProgress', '(I)V');
 env^.CallVoidMethodA(env,AsyncTask,_jMethod,@_jParams);
end;

//by jmpessoa
Procedure jAsyncTask_SetAutoPublishProgress(env:PJNIEnv;this:jobject; AsyncTask : jObject; Value : boolean);
var
 _jMethod : jMethodID = nil;
 _jParams : Array[0..0] of jValue;
  cls: jClass;
begin
 _jParams[0].z := JBool(Value);
  cls := env^.GetObjectClass(env, AsyncTask);
 _jMethod:= env^.GetMethodID(env, cls, 'SetAutoPublishProgress', '(Z)V');
 env^.CallVoidMethodA(env, AsyncTask,_jMethod,@_jParams);
end;

{jSqliteCursor by jmpessoa}

Function jSqliteCursor_Create(env: PJNIEnv; this:jobject;  SelfObj: TObject): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..0] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env);           {a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jSqliteCursor_Create', '(J)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
end;

Procedure jSqliteCursor_Free(env:PJNIEnv;this:jobject; SqliteCursor: jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
begin
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
  env^.CallVoidMethod(env, SqliteCursor,_jMethod);
  env^.DeleteGlobalRef(env,SqliteCursor);
end;

procedure jSqliteCursor_SetCursor(env:PJNIEnv; this: jobject; SqliteCursor: jObject; Cursor: jObject);
var
   _jMethod : jMethodID = nil;
   cls: jClass;
   _jParam: array[0..0] of jValue;
begin
  _jParam[0].l:= Cursor;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'SetCursor', '(Landroid/database/Cursor;)V');
  env^.CallVoidMethodA(env, SqliteCursor,_jMethod, @_jParam);
end;

Function jSqliteCursor_GetCursor (env:PJNIEnv; this:jobject; SqliteCursor: jObject) : jObject;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetCursor', '()Landroid/database/Cursor;');
 Result := env^.CallObjectMethod(env,SqliteCursor,_jMethod);
end;

procedure jSqliteCursor_MoveToFirst(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'MoveToFirst', '()V');
 env^.CallVoidMethod(env,SqliteCursor,_jMethod);
end;

procedure jSqliteCursor_MoveToNext(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'MoveToNext', '()V');
 env^.CallVoidMethod(env,SqliteCursor,_jMethod);
end;

procedure jSqliteCursor_MoveToLast(env:PJNIEnv; this:jobject; SqliteCursor: jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'MoveToLast', '()V');
 env^.CallVoidMethod(env,SqliteCursor,_jMethod);
end;

procedure jSqliteCursor_MoveToPosition(env:PJNIEnv; this:jobject; SqliteCursor: jObject; position: integer);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _lparam: array[0..0] of jValue;
begin
 _lparam[0].i := position;
 cls := env^.GetObjectClass(env, SqliteCursor);
   _jMethod:= env^.GetMethodID(env, cls, 'MoveToPosition', '(I)V');
 env^.CallVoidMethodA(env,SqliteCursor,_jMethod, @_lparam);
end;

Function jSqliteCursor_GetRowCount(env:PJNIEnv; this:jobject; SqliteCursor: jObject): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetRowCount', '()I');
 Result := env^.CallIntMethod(env,SqliteCursor,_jMethod);
end;

Function jSqliteCursor_GetColumnCount(env:PJNIEnv; this:jobject; SqliteCursor: jObject):  integer;
var
  _jMethod : jMethodID = nil;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetColumnCount', '()I');
  Result:= env^.CallIntMethod(env,SqliteCursor,_jMethod);
end;

Function jSqliteCursor_GetColumName(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): string;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
 _jString  : jString;
 _jBoolean : jBoolean;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetColumName', '(I)Ljava/lang/String;');
  _jString   := env^.CallObjectMethodA(env,SqliteCursor,_jMethod,@_jParam);
  case _jString = nil of
    True : Result    := '';
    False: begin
            _jBoolean := JNI_False;
            Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
           end;
  end;
end;

Function jSqliteCursor_GetColumnIndex(env:PJNIEnv; this:jobject; SqliteCursor: jObject; colName: string): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
 _jParam[0].l := env^.NewStringUTF(env, pchar(colName));
 cls := env^.GetObjectClass(env, SqliteCursor);
 _jMethod:= env^.GetMethodID(env, cls, 'GetColumnIndex', '(Ljava/lang/String;)I');
 Result := env^.CallIntMethodA(env,SqliteCursor,_jMethod, @_jParam);
 env^.DeleteLocalRef(env,_jParam[0].l);
end;

Function jSqliteCursor_GetColType(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): integer;
var
 _jMethod: jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
 _jParam[0].i:= columnIndex;
 cls:= env^.GetObjectClass(env, SqliteCursor);
 _jMethod:= env^.GetMethodID(env, cls, 'GetColType', '(I)I');
 Result := env^.CallIntMethodA(env,SqliteCursor,_jMethod, @_jParam);
end;

Function jSqliteCursor_GetValueAsString(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): string;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
  _jString  : jString;
 _jBoolean : jBoolean;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetValueAsString', '(I)Ljava/lang/String;');
  _jString   := env^.CallObjectMethodA(env,SqliteCursor,_jMethod,@_jParam);
  case _jString = nil of
    True : Result    := '';
    False: begin
            _jBoolean := JNI_False;
            Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
          end;
  end;
end;

function jSqliteCursor_GetValueAsBitmap(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): jObject;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetValueAsBitmap', '(I)Landroid/graphics/Bitmap;');
  Result:= env^.CallObjectMethodA(env,SqliteCursor,_jMethod,@_jParam);
end;

function jSqliteCursor_GetValueAsInteger(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): integer;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetValueAsInteger', '(I)I');
  Result:= env^.CallIntMethodA(env,SqliteCursor,_jMethod,@_jParam);
end;

function jSqliteCursor_GetValueAsDouble(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): double;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetValueAsDouble', '(I)D');
  Result:= env^.CallDoubleMethodA(env,SqliteCursor,_jMethod,@_jParam);
end;

function jSqliteCursor_GetValueAsFloat(env:PJNIEnv; this:jobject; SqliteCursor: jObject; columnIndex: integer): real;
var
 _jMethod : jMethodID = nil;
 cls: jClass;
 _jParam: array[0..0] of jValue;
begin
  _jParam[0].i := columnIndex;
  cls := env^.GetObjectClass(env, SqliteCursor);
  _jMethod:= env^.GetMethodID(env, cls, 'GetValueAsFloat', '(I)F');
  Result:= env^.CallDoubleMethodA(env,SqliteCursor,_jMethod,@_jParam);
end;

 {jSqliteDataAccess - by jmpessoa}

Function  jSqliteDataAccess_Create(env: PJNIEnv; this:jobject;  SelfObj: TObject;
                                         dataBaseName: string; colDelimiter: char; rowDelimiter: char): jObject;
var
 _jMethod : jMethodID = nil;
 _jParams : array[0..3] of jValue;
 cls: jClass;
begin
  cls:= Get_gjClass(env);           {a jmethodID is not an object. So don't need to convert it to a GlobalRef!}
  _jMethod:= env^.GetMethodID(env, cls, 'jSqliteDataAccess_Create', '(JLjava/lang/String;CC)Ljava/lang/Object;');
  _jParams[0].j := Int64(SelfObj);
  _jParams[1].l := env^.NewStringUTF(env, pchar(dataBaseName));
  _jParams[2].c := jChar(colDelimiter);
  _jParams[3].c := jChar(rowDelimiter);
  Result := env^.CallObjectMethodA(env, this, _jMethod,@_jParams);
  Result := env^.NewGlobalRef(env,Result);
  env^.DeleteLocalRef(env,_jParams[1].l);
end;

//by jmpessoa
Procedure jSqliteDataAccess_Free(env:PJNIEnv;this:jobject; SqliteDataBase : jObject);
var
 _jMethod : jMethodID = nil;
 cls: jClass;
begin
 cls := env^.GetObjectClass(env, SqliteDataBase);
 _jMethod:= env^.GetMethodID(env, cls, 'Free', '()V');
 env^.CallVoidMethod(env,SqliteDataBase,_jMethod);
 env^.DeleteGlobalRef(env,SqliteDataBase);
end;

//java: public void ExecSQL(String execQuery)
Procedure jSqliteDataAccess_ExecSQL(env:PJNIEnv;this:jobject; SqliteDataBase : jObject; execQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(execQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'ExecSQL', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jSqliteDataAccess_OpenOrCreate(env:PJNIEnv;this:jobject; SqliteDataBase : jObject; dataBaseName: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(dataBaseName));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'OpenOrCreate', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jSqliteDataAccess_AddTableName(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; tableName: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(tableName));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'AddTableName', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jSqliteDataAccess_AddCreateTableQuery(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; createTableQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(createTableQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'AddCreateTableQuery', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jSqliteDataAccess_CreateTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; createQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(createQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'ExecSQL', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

Procedure jSqliteDataAccess_DropTable(env:PJNIEnv; this:jobject; SqliteDataBase: jObject; tableName: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(tableName));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'ExecSQL', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

function jSqliteDataAccess_Select(env:PJNIEnv; this:jobject; SqliteDataBase:jObject; selectQuery: string): string;
var
  _jMethod : jMethodID = nil;
  _jString : jString;
  _jBoolean: jBoolean;
  _jParams : array[0..0] of jValue;
  cls: jClass;
begin
  cls := env^.GetObjectClass(env, SqliteDataBase);
  _jMethod:= env^.GetMethodID(env, cls, 'SelectS', '(Ljava/lang/String;)Ljava/lang/String;');
  _jParams[0].l:= env^.NewStringUTF(env, pchar(selectQuery));
  _jString:= env^.CallObjectMethodA(env,SqliteDataBase,_jMethod, @_jParams);
  case _jString = nil of
    True : Result    := '';
    False: begin
           _jBoolean := JNI_False;
           Result    := String( env^.GetStringUTFChars(env,_jString,@_jBoolean) );
          end;
  end;
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

procedure jSqliteDataAccess_Select(env:PJNIEnv; this:jobject; SqliteDataBase: jObject; selectQuery: string);
var
  cls: jClass;
  _methodID: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, PChar(selectQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'SelectV', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, _methodID,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

function jSqliteDataAccess_GetCursor(env:PJNIEnv; this:jobject; SqliteDataBase: jObject): jObject;
var
  cls: jClass;
  _methodID: jmethodID;
begin
  cls := env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'GetCursor', '()Landroid/database/Cursor;');
  Result  := env^.CallObjectMethod(env, SqliteDataBase, _methodID);
end;

//java:  public boolean CheckDataBase(String pathDB)
function jSqliteDataAccess_CheckDataBaseExists(env:PJNIEnv; this:jobject; SqliteDataBase: jObject; fullPathDB: string): boolean;
var
  cls: jClass;
  _methodID: jmethodID;
  _jParams : array[0..0] of jValue;
  _jBoolean: jBoolean;
begin
  _jParams[0].l := env^.NewStringUTF(env, PChar(fullPathDB));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'CheckDataBaseExists', '(Ljava/lang/String;)V');
  _jBoolean  := env^.CallBooleanMethodA(env, SqliteDataBase, _methodID,@_jParams);
  Result     := boolean(_jBoolean);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

procedure jSqliteDataAccess_CreateAllTables(env:PJNIEnv;this:jobject; SqliteDataBase: jObject);
var
  cls: jClass;
  _methodID: jmethodID;
begin
  cls := env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'CreateAllTables', '()V');
  env^.CallVoidMethod(env, SqliteDataBase, _methodID);
end;

procedure jSqliteDataAccess_DropAllTables(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; recreate: boolean);
var
   cls: jClass;
  _methodID: jmethodID;
  _jParams: array[0..0] of jValue;
begin
  _jParams[0].z:= jBool(recreate);
  cls:= env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'DropAllTables', '(Z)V');
  env^.CallVoidMethodA(env, SqliteDataBase, _methodID,@_jParams);
end;

procedure jSqliteDataAccess_SetSelectDelimiters(env:PJNIEnv;this:jobject; SqliteDataBase: jObject;
                              coldelim: char; rowdelim: char);
var
   cls: jClass;
  _methodID: jmethodID;
  _jParams: array[0..1] of jValue;
begin
 _jParams[0].c := jChar(coldelim);
 _jParams[1].c := jChar(rowdelim);
   cls:= env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'SetSelectDelimiters', '(CC)V');
  env^.CallVoidMethodA(env, SqliteDataBase, _methodID,@_jParams);
end;


procedure jSqliteDataAccess_InsertIntoTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; insertQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(insertQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'InsertIntoTable', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

procedure jSqliteDataAccess_UpdateImage(env:PJNIEnv;this:jobject; SqliteDataBase: jObject;
                                          tableName: string;
                                          imageFieldName: string;
                                          keyFieldName: string;
                                          imageValue: jObject;
                                          keyValue: integer);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..4] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(tableName));
  _jParams[1].l := env^.NewStringUTF(env, pchar(imageFieldName));
  _jParams[2].l := env^.NewStringUTF(env, pchar(keyFieldName));
  _jParams[3].l:= imageValue;
  _jParams[4].i := keyValue;
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'UpdateImage',
                                      '(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;I)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
  env^.DeleteLocalRef(env,_jParams[1].l);
  env^.DeleteLocalRef(env,_jParams[2].l);
end;


procedure jSqliteDataAccess_DeleteFromTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; deleteQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(deleteQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'DeleteFromTable', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

procedure jSqliteDataAccess_UpdateTable(env:PJNIEnv;this:jobject; SqliteDataBase: jObject; updateQuery: string);
var
  cls: jClass;
  method: jmethodID;
  _jParams : array[0..0] of jValue;
begin
  _jParams[0].l := env^.NewStringUTF(env, pchar(updateQuery));
  cls := env^.GetObjectClass(env, SqliteDataBase);
  method:= env^.GetMethodID(env, cls, 'UpdateTable', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, SqliteDataBase, method,@_jParams);
  env^.DeleteLocalRef(env,_jParams[0].l);
end;

procedure jSqliteDataAccess_Close(env:PJNIEnv;this:jobject; SqliteDataBase: jObject);
var
   cls: jClass;
  _methodID: jmethodID;
begin
   cls:= env^.GetObjectClass(env, SqliteDataBase);
  _methodID:= env^.GetMethodID(env, cls, 'Close', '()V');
  env^.CallVoidMethod(env, SqliteDataBase, _methodID);
end;

procedure jSqliteDataAccess_SetForeignKeyConstraintsEnabled(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _value: boolean);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].z:= JBool(_value);
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'SetForeignKeyConstraintsEnabled', '(Z)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
end;


procedure jSqliteDataAccess_SetDefaultLocale(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject);
var
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'SetDefaultLocale', '()V');
  env^.CallVoidMethod(env, _jsqlitedataaccess, jMethod);
end;


procedure jSqliteDataAccess_DeleteDatabase(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _dbName: string);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].l:= env^.NewStringUTF(env, PChar(_dbName));
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'DeleteDatabase', '(Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
env^.DeleteLocalRef(env,jParams[0].l);
end;


procedure jSqliteDataAccess_UpdateImage(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _tabName: string; _imageFieldName: string; _keyFieldName: string; _imageResIdentifier: string; _keyValue: integer);
var
  jParams: array[0..4] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].l:= env^.NewStringUTF(env, PChar(_tabName));
  jParams[1].l:= env^.NewStringUTF(env, PChar(_imageFieldName));
  jParams[2].l:= env^.NewStringUTF(env, PChar(_keyFieldName));
  jParams[3].l:= env^.NewStringUTF(env, PChar(_imageResIdentifier));
  jParams[4].i:= _keyValue;
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'UpdateImage', '(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
env^.DeleteLocalRef(env,jParams[0].l);
  env^.DeleteLocalRef(env,jParams[1].l);
  env^.DeleteLocalRef(env,jParams[2].l);
  env^.DeleteLocalRef(env,jParams[3].l);
end;


procedure jSqliteDataAccess_InsertIntoTableBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _insertQueries: TDynArrayOfString);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
  newSize0: integer;
  jNewArray0: jObject=nil;
  i: integer;
begin
  newSize0:= Length(_insertQueries);
  jNewArray0:= env^.NewObjectArray(env, newSize0, env^.FindClass(env,'java/lang/String'),env^.NewStringUTF(env, PChar('')));
  for i:= 0 to newSize0 - 1 do
  begin
     env^.SetObjectArrayElement(env,jNewArray0,i,env^.NewStringUTF(env, PChar(_insertQueries[i])));
  end;
  jParams[0].l:= jNewArray0;
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'InsertIntoTableBatch', '([Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
env^.DeleteLocalRef(env,jParams[0].l);
end;


procedure jSqliteDataAccess_UpdateTableBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _updateQueries: TDynArrayOfString);
var
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
  newSize0: integer;
  jNewArray0: jObject=nil;
  i: integer;
begin
  newSize0:= Length(_updateQueries);
  jNewArray0:= env^.NewObjectArray(env, newSize0, env^.FindClass(env,'java/lang/String'),env^.NewStringUTF(env, PChar('')));
  for i:= 0 to newSize0 - 1 do
  begin
     env^.SetObjectArrayElement(env,jNewArray0,i,env^.NewStringUTF(env, PChar(_updateQueries[i])));
  end;
  jParams[0].l:= jNewArray0;
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'UpdateTableBatch', '([Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
env^.DeleteLocalRef(env,jParams[0].l);
end;


function jSqliteDataAccess_CheckDataBaseExistsByName(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; _dbName: string): boolean;
var
  jBoo: JBoolean;
  jParams: array[0..0] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
begin
  jParams[0].l:= env^.NewStringUTF(env, PChar(_dbName));
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'CheckDataBaseExistsByName', '(Ljava/lang/String;)Z');
  jBoo:= env^.CallBooleanMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
  Result:= boolean(jBoo);
   env^.DeleteLocalRef(env,jParams[0].l);
end;

procedure jSqliteDataAccess_UpdateImageBatch(env: PJNIEnv; this: JObject; _jsqlitedataaccess: JObject; var _imageResIdentifierDataArray: TDynArrayOfString; _delimiter: string);
var
  jParams: array[0..1] of jValue;
  jMethod: jMethodID=nil;
  jCls: jClass=nil;
  newSize0: integer;
  jNewArray0: jObject=nil;
  i: integer;
begin
  newSize0:= Length(_imageResIdentifierDataArray);
  jNewArray0:= env^.NewObjectArray(env, newSize0, env^.FindClass(env,'java/lang/String'),env^.NewStringUTF(env, PChar('')));
  for i:= 0 to newSize0 - 1 do
  begin
     env^.SetObjectArrayElement(env,jNewArray0,i,env^.NewStringUTF(env, PChar(_imageResIdentifierDataArray[i])));
  end;
  jParams[0].l:= jNewArray0;
  jParams[1].l:= env^.NewStringUTF(env, PChar(_delimiter));
  jCls:= env^.GetObjectClass(env, _jsqlitedataaccess);
  jMethod:= env^.GetMethodID(env, jCls, 'UpdateImageBatch', '([Ljava/lang/String;Ljava/lang/String;)V');
  env^.CallVoidMethodA(env, _jsqlitedataaccess, jMethod, @jParams);
  env^.DeleteLocalRef(env,jParams[0].l);
  env^.DeleteLocalRef(env,jParams[1].l);
end;

//------------------------------------------------------------------------------
// jHttp_Get
//------------------------------------------------------------------------------

//
Function  jHttp_Get(env:PJNIEnv; this:jobject; URL : String) : String;
Const
 _cFuncName = 'jHttp_get';
 _cFuncSig  = '(Ljava/lang/String;)Ljava/lang/String;';
Var
 _jMethod  : jMethodID = nil;
 _jString  : jString;
 _jBoolean : jBoolean;
 _jParam   : jValue;
begin
 //gVM^.AttachCurrentThread(gVm,@env,nil);   //fix by jmpessoa
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l  := env^.NewStringUTF(env, pchar(URL) );
 _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParam);
 Case _jString = nil of
  True : Result    := '';
  False: begin
          _jBoolean := JNI_False;
          Result    := String( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
         end;
 end;
 env^.DeleteLocalRef(env,_jParam.l);
 //dbg('Http_Get:'+ Result);
end;


//by jmpessoa
procedure jSend_Email(env:PJNIEnv;this:jobject;
                       sto: string;
                       scc: string;
                       sbcc: string;
                       ssubject: string;
                       smessage:string);
Const
 _cFuncName = 'jSend_Email';
 _cFuncSig  = '(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..4] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := env^.NewStringUTF(env, pchar(sto) );
 _jParams[1].l := env^.NewStringUTF(env, pchar(scc) );
 _jParams[2].l := env^.NewStringUTF(env, pchar(sbcc) );
 _jParams[3].l := env^.NewStringUTF(env, pchar(ssubject) );
 _jParams[4].l := env^.NewStringUTF(env, pchar(smessage) );
 env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
 env^.DeleteLocalRef(env,_jParams[1].l);
 env^.DeleteLocalRef(env,_jParams[2].l);
 env^.DeleteLocalRef(env,_jParams[3].l);
 env^.DeleteLocalRef(env,_jParams[4].l);
end;


//by jmpessoa
function jSend_SMS(env:PJNIEnv;this:jobject;
                       toNumber: string;
                       smessage:string): integer;
Const
 _cFuncName = 'jSend_SMS';
 _cFuncSig  = '(Ljava/lang/String;Ljava/lang/String;)I';
Var
 _jMethod : jMethodID = nil;
 _jParams : array[0..1] of jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := env^.NewStringUTF(env, pchar(toNumber) );
 _jParams[1].l := env^.NewStringUTF(env, pchar(smessage) );
 Result:= env^.CallIntMethodA(env,this,_jMethod,@_jParams);
 env^.DeleteLocalRef(env,_jParams[0].l);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

//by jmpessoa
function jContact_getMobileNumberByDisplayName(env:PJNIEnv;this:jobject;
                                               contactName: string): string;
const
 _cFuncName = 'jContact_getMobileNumberByDisplayName';
 _cFuncSig  = '(Ljava/lang/String;)Ljava/lang/String;';
var
 _jMethod  : jMethodID = nil;
 _jString  : jString;
 _jBoolean : jBoolean;
 _jParams : array[0..0] of jValue;

begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := env^.NewStringUTF(env, pchar(contactName) );
 _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
 case _jString = nil of
  True : Result    := '';
  False: begin
          _jBoolean := JNI_False;
          Result    := string( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
         end;
 end;
 env^.DeleteLocalRef(env,_jParams[0].l);
end;

//by jmpessoa
function jContact_getDisplayNameList(env:PJNIEnv;this:jobject; delimiter: char): string;
const
 _cFuncName = 'jContact_getDisplayNameList';
 _cFuncSig  = '(C)Ljava/lang/String;';
var
 _jMethod  : jMethodID = nil;
 _jString  : jString;
 _jBoolean : jBoolean;
 _jParams : array[0..0] of jValue;

begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].c := jChar(delimiter);
 _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
 case _jString = nil of
  True : Result    := '';
  False: begin
          _jBoolean := JNI_False;
          Result    := string( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
         end;
 end;
end;

//------------------------------------------------------------------------------
// jCamera               - //Use: filename = App.Path.DCIM + '/test.jpg
//------------------------------------------------------------------------------
Procedure jTakePhoto(env:PJNIEnv; this:jobject; filename : String);
Const
 _cFuncName = 'takePhoto';
 _cFuncSig  = '(Ljava/lang/String;)V';
Var
 _jMethod : jMethodID = nil;
 _jParam  : jValue;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParam.l:= env^.NewStringUTF(env, pchar(filename) );
 env^.CallVoidMethodA(env,this,_jMethod,@_jParam);
 env^.DeleteLocalRef(env,_jParam.l);
end;

//by jmpessoa   - //Use: path =  App.Path.DCIM
                  //     filename = '/test.jpg'
function jCamera_takePhoto(env:PJNIEnv; this:jobject; path: string; filename : String): string;
const
 _cFuncName = 'jCamera_takePhoto';
 _cFuncSig  = '(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;';
var
 _jMethod  : jMethodID = nil;
 _jParams : array[0..1] of jValue;
 _jString  : jString;
 _jBoolean : jBoolean;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jParams[0].l := env^.NewStringUTF(env, pchar(path) );
 _jParams[1].l := env^.NewStringUTF(env, pchar(filename) );
 _jString   := env^.CallObjectMethodA(env,this,_jMethod,@_jParams);
 // env^.CallVoidMethodA(env,this,_jMethod,@_jParams);
 case _jString = nil of
  True : Result    := '';
  False: begin
          _jBoolean := JNI_False;
          Result    := string( env^.GetStringUTFChars(Env,_jString,@_jBoolean) );
         end;
 end;
 env^.DeleteLocalRef(env,_jParams[0].l);
 env^.DeleteLocalRef(env,_jParams[1].l);
end;

//------------------------------------------------------------------------------
// jBenchMark
//------------------------------------------------------------------------------

//
// public float[] benchMark1 () {
// 	long start_time;
// 	long end_time;
// 	start_time = System.currentTimeMillis();
// 	//
// 	float value =3;
// 	int i = 0;
// 	for ( i = 0; i < 100000000; i++) {
// 		value = value * 2 / 3 + 5 - 1;
// 	};
// 	end_time = System.currentTimeMillis();
// 	Log.e("BenchMark1","Java : " + (end_time - start_time) + ", result" + value);
// 	//
// 	float[] vals = new float[2];
// 	vals[0] = end_time - start_time;
// 	vals[1] = value;
// 	return ( vals );
// }
Procedure jBenchMark1_Java  (env:PJNIEnv;this:jobject;var mSec : Integer;var value : single);
Const
 _cFuncName = 'benchMark1';
 _cFuncSig  = '()[F';
Var
 _jMethod      : jMethodID = nil;
 _jFloatArray  : jFloatArray;
 _jBoolean     : jBoolean;
 PFloat        : PSingle;
 PFloatSav     : PSingle;
begin
 jClassMethod(_cFuncName,_cFuncSig,env,gjClass,_jMethod);
 _jFloatArray := env^.CallObjectMethod(env,this,_jMethod);
 _jBoolean    := JNI_False;
 PFloat       := env^.GetFloatArrayElements(env,_jFloatArray,_jBoolean);
 PFloatSav    := PFloat;
 mSec         := Round(PFloat^); Inc(PFloat);
 value        := Round(PFloat^); Inc(PFloat);
 env^.ReleaseFloatArrayElements(env,_jFloatArray,PFloatSav,0);
end;

Procedure jBenchMark1_Pascal (env:PJNIEnv;this:jobject;var mSec : Integer;var value : single);
 Var
  StartTime,EndTime : LongInt;
  i                 : Integer;
 begin
  StartTime := jgetTick(env,this);
  value     := 30;
  i         := 0;
  for i := 0 to 100000000-1 do
   value := value * 2/ 3 + 5 - 1;
  EndTime   := jgetTick(env,this);
  dbg( IntToStr( EndTime - StartTime) + ' Result:' + FloatToStr(value) );
  //
  mSec := EndTime - StartTime;
 end;



initialization    //commented by jmpessoa
{ gDbgMode    := True;
 gjAppName   := 'com.example.appx';
 gjClassName := 'com/example/appx/Controls';
 }
end.
