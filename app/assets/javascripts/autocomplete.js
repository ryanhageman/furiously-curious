function autocomplete(input, list) { // eslint-disable-line no-unused-vars
    new Awesomplete(input, {
        list: list,
        filter: function(text, input) {
            return Awesomplete.FILTER_CONTAINS(text, input.match(/[^,]*$/)[0]);
        },

        item: function(text, input) {
            return Awesomplete.ITEM(text, input.match(/[^,]*$/)[0]);
        },

        replace: function(text) {
            var before = this.input.value.match(/^.+,\s*|/)[0];
            this.input.value = before + text + ', ';
        }
    });
}
