exports.GetCollection = function(Model, property) {
	return Model.definition[property].enum;
	// return Model.definition.status.enum;
}
