require 'formula'

class Php54Amqp < Formula
  homepage 'http://pecl.php.net/package/amqp'
  url 'http://pecl.php.net/get/amqp-1.0.3.tgz'
  md5 '1180cd5a425d9443f8435f64e7ee571b'
  head 'http://svn.php.net/repository/pecl/amqp/trunk/', :using => 'svn'

  depends_on 'autoconf' => :build
  depends_on 'rabbitmq-c'

  def install
    Dir.chdir "amqp-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/amqp.so"
  end

  def caveats; <<-EOS.undent
    To finish installing php54-amqp:
      * Add the following lines to #{etc}/php.ini:
        [mongo]
        extension="#{prefix}/amqp.so"
      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the amqp module.
      * If you see it, you have been successful!
    EOS
  end
end
