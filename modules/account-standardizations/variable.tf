variable "PermissionsBoundary" {
	default = ""
}


variable "AllowUsersToChangePassword"{
	default = "true"
}

variable "HardExpiry"{
	default = "false"
}

variable "MaxPasswordAge"{
	default = "90"
}
 
variable "MinimumPasswordLength"{
	default = "14"
}

variable "PasswordReusePrevention"{
	default = "24"
}
 
variable "RequireLowercaseCharacters"{
	default = "true"
}

variable "RequireNumbers"{
	default = "true"
}
 
variable "RequireSymbols"{
	default = "true"
}
  
variable "RequireUppercaseCharacters"{
	default = "true"
}
 
variable "LogsRetentionInDays"{
	default = "14"
}
