<?php

/**
 * Generic class used to parse file listing result.
 */
abstract class GFtpFileListConverter extends CComponent {

	/**
	 * Parse string array (output for ftp_rawlist) an convert each element in GFtpFile.
	 * 
	 * @param string[] $fullList String array returned by ftp_rawlist.
	 *
	 * @return GFtpFile[] Converted file list.
	 */
	public function parse($fullList) {
		$arr = array();
		$parser = new GFtpResultParser();
				
		foreach ($fullList as $line) {
			$line = $parser->parse($line);
			$arr[] = $this->format($line);
		}
		
		return $arr;
	}

	/**
	 * Convert each result line into GFtpFile
	 *
	 * @param string[] $arr splitted result line
	 * 
	 * @return GFtpFile Converted string array.
	 */
	abstract public function format($arr);
}


