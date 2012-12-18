(function (window, $) {
	window.refinery = window.refinery || {};

	function Inquiry (config) {
		var cfg = config || {};

		this.config.id = cfg.id || this.config.id;
		if (cfg.holder) {
			cfg.holder.id = cfg.holder.id || this.config.holder.id;
			cfg.holder['class'] = cfg.holder['class'] || this.config.holder['class'];
			cfg.holder.append_to = cfg.holder.append_to || this.config.holder.append_to;
			this.config.holder = cfg.holder;
		}

		this.config.onbind = cfg.onbind || cfg.onload || this.config.onbind;
		this.config.onsubmit = cfg.onsubmit || this.config.onsubmit;

		this.init();
	}

	Inquiry.prototype = {
		initialized : false,

		config : {
			id : 'new_inquiry',
			holder : {
				id : 'inquiry-form-holder',
				'class' : 'inquiries',
				append_to : '#body .inner'
			},
			// for debug
			// onbind : {
            //     fnc : window.alert,
            //     obj : this,
            //     args : 'Inquiry Form loaded and binded'
            // },
			// onsubmit : {
            //     fnc : window.alert,
            //     obj : this,
            //     args : 'Inquiry Form submitet'
            // }
			onbind : { fnc: null, obj: null, args: [] },
			onsubmit : { fnc: null, obj: null, args: [] }
		},

		process_html: function(html) {
			var that = this;

			for (var i in html) {
				that.updatePartial(i, html[i]);
			}
		},

		// TODO
		process_errors: function(errors) {

		},

		updatePartial: function(id, html) {
			$('#' + id).html(html);
		},

		load : function () {
			var that = this;
			if ($('#' + that.config.holder.id).length === 0) {
				$('<div>', that.config.holder).appendTo(that.config.holder.append_to);
			}

			$.getJSON('/contact', {form_holder_id : that.config.holder.id }, function (response) {
				that.success(response, that.bind);
			});
		},
		success : function (response, callback) {
			var that = this;

			if (response.html) {
				that.process_html(response.html);
			}

			if (response.status === 'error' && response.errors) {
				that.process_errors(response.errors);
			} else if (response.status === 'redirect' && response.to) {
				window.location.href = response.to;
			}

			if (typeof callback === 'function') {
				return that.callback(callback, that);
			}
		},
		callback : function (fnc, obj, args) {
			args = (typeof args === 'string') ? [args] : args;
			return fnc.apply(obj, args);
		},
		bind : function () {
			var that = this;

			$('#' + that.config.holder.id).on('ajax:success', function (event, response) {
				that.success(response);
			}).on('ajax:error', function (xhr, status, error) {
				// TODO process ajax error
				// alert('something went wrong');
			});

			if (that.config.onsubmit && typeof that.config.onsubmit.fnc === 'function') {
				$('#' + that.config.id).on('submit', function () {
					that.callback(that.config.onsubmit.fnc, that.config.onsubmit.obj, that.config.onsubmit.args || []);
				});
			}

			if (that.config.onbind && typeof that.config.onbind.fnc === 'function') {
				that.callback(that.config.onbind.fnc, that.config.onbind.obj, that.config.onbind.args || []);
			}
		},
		init : function () {
			var that = this;

			if ($('#' + that.config.id).length > 0) {
				that.bind();
			} else {
				that.load();
			}

			return that;
		}
	};

	window.refinery.Inquiry = Inquiry;
}(window, jQuery));
