# Thread de mesure de temps
#
class Chronometre < Thread
  # @temps Temps du chronomètre en secondes
  # @chrono_label Version GUI du chronomètre
  # @running Variable d'état du chronomètre

  attr :temps, true
  attr :running, true

  def initialize(chrono_label)
    @temps = 0
    @chrono_label = chrono_label
    @running = false

    super() do
      while @running
        update
        sleep(1)
      end
    end
  end

  #
  # Met à jour le temps du chrono et la version GUI du chrono
  #
  def update
    @temps += 1

    @chrono_label.set_text(second_beautiful)
  end

  def start
    @running = true
    run
  end

  def stop
    @running = false
  end

  #
  # Fonction de mise au propre du temps en heures/minutes/secondes
  #
  def second_beautiful
    heures = @temps / 3600
    minutes = (@temps - 3600 * heures) / 60
    secondes = (@temps - 3600 * heures) - 60 * minutes

    "#{heures} : #{minutes} : #{secondes}"
  end
end
