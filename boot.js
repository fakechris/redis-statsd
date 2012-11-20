/* Boot The Server
 *
 * Most "runners" (e.g. node) will expect js, but most of
 *  the code is in coffeescript, so this guy grabs coffee
 *  and fires up the server(s).
 *
 */

require('coffee-script');
require('./app');
