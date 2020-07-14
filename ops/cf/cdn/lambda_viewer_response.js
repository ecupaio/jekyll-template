'use strict';

exports.handler = (event, context, callback) => {
  const response = event.Records[0].cf.response;
  const headers = response.headers;

  const oneYearInSeconds = 31536000;
  headers['strict-transport-security'] = [{
    key: 'Strict-Transport-Security',
    value: `max-age=${oneYearInSeconds}; includeSubdomains; preload`
  }];

  headers['x-content-type-options'] = [{
    key: 'X-Content-Type-Options',
    value: 'nosniff'
  }];

  headers['x-frame-options'] = [{
    key: 'X-Frame-Options',
    value: 'DENY'
  }];

  headers['x-xss-protection'] = [{
    key: 'X-XSS-Protection',
    value: '1; mode=block'
  }];

  headers['referrer-policy'] = [{
    key: 'Referrer-Policy',
    value: 'same-origin'
  }];

  // pass through requests
  callback(null, response);
};
