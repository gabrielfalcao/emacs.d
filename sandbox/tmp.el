(ignore-errors     (erase-c-messages))
(ignore-errors

  (c-message "hex-to-decimal-region
beg=%S
end=%S
point=%S
point-min=%S
point-max=%S
"
	     beg
	     end
	     (point)
	     (point-min)
	     (point-max)

	     ))
