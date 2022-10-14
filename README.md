## GA4D - Google Analytic for Delphi

### The GA4D library was created so that applications developed in Delphi can be analyzed more precisely, giving the possibility of better decision making on the behavior of users in the application.

* Link online and offline behaviors;
* Evaluate client-side and server-side interactions;
* Send events that happen outside of standard user interaction (e.g. offline conversions);
* Send events from devices and applications that do not have automatic collection available (e.g. kiosks, clocks, etc.).

> ###### In order to send the events to the GA4, it is necessary to pass the following parameters to the GA4D:
> - APISecret
>    To create a new secret, navigate the Google Analytics UI to:
>    **Administrator > Data flow > choose your flow > Measurement Protocol > Create**
> > [!IMPORTANT]
> > It is recommended that you keep this information private within your organization, or as best you like, as long as you have greater security about this information.
> - ClientID:
>    Uniquely identifies an instance of your application.
> - UserID:
>    Optional. Identifies the user, which can be some identification tag for your system, but can be added >    to the ClientID name.
> - MeasurementID:
>    Id de Métricas. Identificador do fluxo de dados. Ele pode ser encontrado na IU do Google Analytics em:
>    **Administrator > Data Flow > Choose Your Flow > Metrics Id.**

#### Once you are in possession of the GA4 validation codes, simply add this information into your system:

###### declare a variable so it can be used in your project:

```delphi
    private
        FGA4D: iGA4D;
```

###### In order for the library to have the settings registered, it is necessary to call this way:

```delphi
    FGA4D := TGA4D.New;
    FGA4D
    .Config
      .APISecret(APISECRET)
      .ClientId(CLIENTID)
      .UserId(USERID)
      .MeasurementId(MEASUREMENTID); 
```

###### Within your system, just call the event you want so that it is registered in GA

```delphi
    FGA4D
        .Build
        .Name('Name of the event that will be held in GA')
        .Engagement('Event call time in milliseconds')
        .Push;
```

> [!TIP]
> For better understanding of using the library, we have an example unit test.