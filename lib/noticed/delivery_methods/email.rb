module Noticed
  module DeliveryMethods
    class Email < Base
      def deliver
        mailer.with(format).send(method.to_sym).deliver_later
      end

      private

      def mailer
        options.fetch(:mailer).constantize
      end

      def method
        options[:method] || notification.class.name.underscore
      end

      def format
        if (method = options[:format])
          notification.send(method)
        else
          {
            notification: notification,
            recipient: recipient
          }
        end
      end
    end
  end
end
