class Radio
  attr_accessor :band
  attr_reader :frequency, :volume

  FREQUENCIES = ['FM', 'AM'].freeze

  FM_FREQUENCY_RANGE = 88.0..108.0
  AM_FREQUENCY_RANGE = 540.0..1600.0

  @@fm_frequency_default = 88.0
  @@am_frequency_default = 540.0
  @@default_volume = 5

  # @param options [Hash]
  # @option options [Integer] :volume Початкова гучність (від 1 до 10). За замовчуванням: 1.
  # @option options [String]  :band   Початковий діапазон ('FM' або 'AM'). За замовчуванням: 'FM'.
  # @option options [Float]   :frequency Початкова частота радіо. За замовчуванням: дефолтна частота для обраного діапазону.
  def initialize(options = {})
    self.volume = options[:volume] || @@default_volume
    self.band = options[:band] || FREQUENCIES[0]
    self.frequency = options[:frequency] if options.key?(:frequency)
  end

  def volume=(value)
    return unless (1..10).include?(value)
    @volume = value
  end

  def band=(value)
    return unless FREQUENCIES.include? value
    @band = value
    change_frequency(band)
    @band
  end

  def frequency=(value)
    if band == FREQUENCIES[0]
      return unless FM_FREQUENCY_RANGE.include?(value)
      @frequency = value.to_f
    elsif band == FREQUENCIES[1]
      return unless AM_FREQUENCY_RANGE.include?(value)
      @frequency = value.to_f
    end
  end

  def status
    "-station: #{frequency} #{band}  -volume: #{volume}"
  end

  def self.fm
    Radio.new(volume: 5, band: 'FM', frequency: 88.0)
  end

  def self.am
    Radio.new(volume: 5, band: 'AM', frequency: 1000.0)
  end

  private

  def change_frequency(band)
    if band == FREQUENCIES[0]
      @frequency = @@fm_frequency_default
    else
      @frequency = @@am_frequency_default
    end
  end

end
