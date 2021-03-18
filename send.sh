curl --location --request POST 'http://localhost:4001/push/v3.0' \
--header 'Authorization: Basic bWVkaWNvcmU6bWVkaWNvcmU=' \
--header 'Content-Type: application/json' \
--data '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:ns1="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3"
    xmlns:ns2="http://schemas.vecozo.nl/berichtuitwisseling/v3"
    xmlns:ns3="http://schemas.vecozo.nl/berichtuitwisseling/types/v3"
    xmlns:ns4="http://schemas.vecozo.nl/berichtuitwisseling/header/v3">
    <SOAP-ENV:Header>
        <ns2:VerwerkingscontextHeader>
            <ns4:Aspect>
                <ns3:Sleutel>Applicatie</ns3:Sleutel>
                <ns3:Waarde>JWApplicatie</ns3:Waarde>
            </ns4:Aspect>
            <ns4:Aspect>
                <ns3:Sleutel>ApplicatieSubversie</ns3:Sleutel>
                <ns3:Waarde>0</ns3:Waarde>
            </ns4:Aspect>
            <ns4:Aspect>
                <ns3:Sleutel>ApplicatieVersie</ns3:Sleutel>
                <ns3:Waarde>1</ns3:Waarde>
            </ns4:Aspect>
            <ns4:Aspect>
                <ns3:Sleutel>Referentienummer</ns3:Sleutel>
                <ns3:Waarde>fc6d5c90-5630-4270-aba2-bc1be7936502</ns3:Waarde>
            </ns4:Aspect>
        </ns2:VerwerkingscontextHeader>
        <ns2:ConversatieHeader>
            <ns4:ConversatieId>fc6d5c90-5630-4270-aba2-bc1be7936502</ns4:ConversatieId>
            <ns4:TraceerId>fc6d5c90-5630-4270-aba2-bc1be7936502</ns4:TraceerId>
        </ns2:ConversatieHeader>
        <ns2:ReferentieHeader>
            <ns4:ReferentieId>35999dce-1f8d-4aa7-b075-176dc618afa0</ns4:ReferentieId>
        </ns2:ReferentieHeader>
        <ns2:RouteringHeader>
            <ns4:Afzender>
                <ns3:Rol>Instelling</ns3:Rol>
                <ns3:Code>22227338</ns3:Code>
            </ns4:Afzender>
            <ns4:Geadresseerden>
                <ns3:Relatie>
                    <ns3:Rol>Gemeente</ns3:Rol>
                    <ns3:Code>0344</ns3:Code>
                </ns3:Relatie>
            </ns4:Geadresseerden>
            <ns4:Berichttype>JW</ns4:Berichttype>
            <ns4:Berichtsubtype>JW315</ns4:Berichtsubtype>
            <ns4:Berichtversie>3</ns4:Berichtversie>
            <ns4:Berichtsubversie>0</ns4:Berichtsubversie>
            <ns4:Actie>VerzoekToewijzing</ns4:Actie>
        </ns2:RouteringHeader>
    </SOAP-ENV:Header>
    <SOAP-ENV:Body>
        <ns2:IndienenBericht>
            <ns2:Request>
                <ns1:Bericht xsi:type="ns1:DataBinary"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                    <ns1:Data xmlns:ns1="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3">UEsDBBQAAgAIAOiJM1JK4iCoeQIAAMcHAAAoAAAAODdjMjdkMjUtOTA2My00NjgzLTlkOGUtOGMxMGU3NjZiMDUwLnhtbI1U23LaMBB9z1cweQ++4WAY6hmgtzw0yTQJ0z51BF6MqJFTSYSWr+/akmz5wrR+8fjs2d2zxyvN9qfAC6cL4HSzk4Pfh4yJKd2f3l3vpHydOs7pdBpSIQlLCOEJsCHLHIw7wQ/XWRNBhdjs4EAc9brWFcqq/1WjZJrs+GowmClFn4EkwAuggrTIZZ5APBrdzpwu3ENfARcU4qBF13BPwtNx/aaCbiunjthp8+0ZWKHVx2ccBJHJqgI2+4HJN8JSRN1gNDLUGu0RdIeWSbqlGyJNa6SggdNm5MvSdaNocjsPw8nM6cbtzPcklfATGGVp7Lu+d+N6N57OsmNKjvMvPVrwN5HYvupei3pNaoI39Ieu6tcbbxRQfe1kd+jr5HasobgBG7BeLS17mVGcqGm9YPEEHxefetMQtEmfYJ3nXEJC5PHQsrdAfEwujHU9Y2zFMyV7SlTFRUZwstiruRqxafeENFsblmBWRMfmiAMvAytOQShZFmoKORcrlXVWqDkDiVkiflRkG2pMWAusBjuTVCSc4Lovij1L7BE7scZRK87IGyckTeCR58lxI4FVyjocTbFMUJSvsAVe7DAgeU2h2IYoQnDse0E4CaOx0dPHbFfrdNEmLYmENEeb41GoPKqRDre4vL4/eS+aWN1ltpOXxnnO4UT3ZzyudyzF6UWit08da7dy9wKxXe/hUNxFHY2rPDseIC7MsT7brA/AdkCTOAoUzXy3eR85/DqWzsYjxbSQzuhtSVopnu1iIPun6PLPf17x/tbnrvxoM8q9fJEccMMV7b55YJyLPcwaIX+TM8kJ/hS/WhkbvWrWurSbPfHmfhuCualaN3L8F1BLAQI/AxQAAgAIAOiJM1JK4iCoeQIAAMcHAAAoAAAAAAAAAAAAAAC2gQAAAAA4N2MyN2QyNS05MDYzLTQ2ODMtOWQ4ZS04YzEwZTc2NmIwNTAueG1sUEsFBgAAAAABAAEAVgAAAL8CAAAAAA==</ns1:Data></ns1:Bericht>
            </ns2:Request>
        </ns2:IndienenBericht>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>'