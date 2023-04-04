<?php
use probo\synthes\InternalException;
use function probo\synthes\hr;
use probo\synthes\Log;
use function probo\synthes\dropNumericKeys;
use probo\synthes\WikiData;

/**
 *
 *
 * @author Serj.by
 * @copyright 2023 by Serj.by
 *
 */

define ("ST_CSVPARSE_STARTFROM", 1);
define ("ST_CSVPARSE_STOPAT", 2000);

require __DIR__."/../includes/globals.php";


// $fn = __DIR__."/../../_words_ru/_ru_indices/ru_indices_raw_wnames.csv";

// $fn = __DIR__."/../../_words_ru/_ru_indices/ru_lists_essent_startswith_e.csv";


$fn = __DIR__."/../../_words_ru/_ru_lists/ru_lists_wnames.csv";

$f = fopen ($fn, "r");
if ($f === FALSE) {
    throw new InternalException("Cannot read CSV file ".$fn);
}
global $listWordsRE;
//define ("PARSE_STARTLTRS_FROM_TEXT", FALSE);
$i=0;
$wordsAr=[];
// BEGIN LOOP THROUGH ROWS
while ($row=fgetcsv($f, null, ',', '\'')) {
    // Check if it is first (header) row or outside of parsing bounds
    if ($i++ == 0) {
        // If so, skip it - there is nothing interesting
        continue;
    } else {
        // Check if it is row outside of parsing bounds
        if ($i<ST_CSVPARSE_STARTFROM || $i>ST_CSVPARSE_STOPAT) {
            Log::log(Log::$LVL_INFO, "Skip row  #$i as out of bounds one");
            continue;
        }
        // If not, fill appropriate string keys in row array. Please note that CSV file must have corresponding structure
        $row["text_id"]=$row[0];
        $row["page_title"]=$row[1];
        $row["txt"]=$row[2];
    }
/*
    $startLtrs="--";
    if (PARSE_STARTLTRS_FROM_TEXT) {
        global $startLtrsListWordsTxtRE, $startLtrsListWordsTxtREDataGrp;
    //     if ($i > 10) break;
//        print("Line ".($i)." (tid ".$r["text_id"].", pt: ".$r["page_title"]."): ".$r["txt"]);
        $m=[];
        $mn=preg_match_all($startLtrsListWordsTxtRE, $r[2], $m);
        if (is_array($m ["startLtrs"]) && sizeof($m [$startLtrsListWordsTxtREDataGrp]) > 0)
            $startLtrs = $m [$startLtrsListWordsTxtREDataGrp][0];
    } else {
        global $startLtrsListWordsTitleRE, $startLtrsListWordsTitleREDataGrp;
        $m=[];
        $mn=preg_match_all($startLtrsListWordsTitleRE, $r[1], $m);
        if (is_array($m [$startLtrsListWordsTitleREDataGrp]) && sizeof($m [$startLtrsListWordsTitleREDataGrp]) > 0)
            $startLtrs = $m [$startLtrsListWordsTitleREDataGrp][0];
    }
    $startLtrs = mb_strtoupper(str_replace("/", "", $startLtrs));
*/
    $m=[];
    $mn=preg_match_all($listWordsRE, $row[2], $m);
    $wordsCurListAr = $m["word"];
    $wordsAr = array_merge($wordsAr, $wordsCurListAr); 
}
// END LOOP THROUGH ROWS


Log::log(Log::$LVL_INFO, "Words parsed from CSV:\n".implode ("\n",$wordsAr));

Log::log(Log::$LVL_INFO, "Words parsed from CSV saving to DB:\n");
foreach ($wordsAr as $wt) {
    $wd = new WikiData(WikiData::MODE_NS_WORD, True);
    $wd->page_title = $wt;
    $wd->lookup("page_title", $wt);
    $wd->addAsWord();
    print ($wd);
}
