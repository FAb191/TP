# TP HBase

Vérifiez d'abord que HBase est démarré (sinon démarrez la machine !)
Movie Dataset: http://files.grouplens.org/datasets/movielens/ml-latest-small.zip

## Exercice 1:
Essayez déjà de démarrer hbase shell, et lancez quelques commandes basiques: création namespace, table, insertions, scan avec limite

Créez une table "movies" sous un namespace "telecom".
Insérez ensuite quelques données du csv movies.csv dans la table
Modifier le titre d'un film, et appelez-le "Hadoop Paris"

Insérez toutes les données dans la table HBase. Au moins 3 solutions s'offrent à vous:
- commande Awk (attention avec les "", pas évident que les données ne soient pas corrompues)
- Job MapReduce Hbase interne (à vous de trouver la commande au moins!)
- Hive :) , vous devez maintenant bien maîtriser !

Utilisez au moins la solution Hive et le Job MR HBase.
Créez une table Hive externe sur la table HBase.
- Récupérez tous les films sortis en 2012
- Comptez tous les films de 2012 dont le genre est associé à Comedy
- Comptez le nombre de lignes dans votre CSV, et dans votre table HBase

Commandes Hbase:
```
create_namespace, list_namespace, list_namespace_tables, ...
create 'namespace:table_name', 'colfamily'
put 'namespace:table_name','rowkey','colfamily:colname','value'
scan 'namespace:table_name'
get 'namespace:table_name', 'rowkey'
```

## Exercice 2: Ecrire des données avec une application Java

Développez une application Java afin de lire les données du fichier movies.csv, et les insérer dans une table HBase (créez une autre table avant, avec un autre nom).
Vous pouvez également écrire une méthode qui permet de requêter les données par rowkey.

Tips pour démarrer:
Créer un nouveau projet Maven avec pour groupId: org.telecom.tp5 et pour ArtifactId: hbase-project

Ajouter les dépendences suivantes:
```xml
<dependencies>
        <dependency>
            <groupId>org.apache.hbase</groupId>
            <artifactId>hbase-client</artifactId>
            <version>1.5.0</version>
        </dependency>
</dependencies>
```


Pour packager votre projet en jar avec toutes les dépendences:
```xml
<build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.2.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>org.sonatype.haven.HavenCli</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
</build>
```

Essayez de lancer le projet depuis votre poste, ou lancez-le depuis la Sandbox. 
Pour le lancer en local (pas sur la Sandbox), ajoutez un minimum de configuration afin de pouvoir vous connecter à HBase 
(cela devrait suffire, sinon essayez avec le hbase-site.xml que vous pouvez récupérer de la Sandbox): 
```java
config.set("hbase.zookeeper.property.clientPort", "2181");
config.set("hbase.zookeeper.quorum", "127.0.0.1");
config.set("zookeeper.znode.parent", "/hbase-unsecure");
```

Sinon, packagez le projet et transférez le sur la Sandbox:
`scp -P 2222 votreApplication.jar username@hostname:/chemin/vers/votre/directory/`

## Solutions
https://www.gnu.org/software/gawk/manual/html_node/Very-Simple.html (pour échapper les simples quotes '' , utilisez `'\''`)

https://cwiki.apache.org/confluence/display/Hive/HBaseIntegration

https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

https://github.com/apache/hbase/blob/master/hbase-examples/src/main/java/org/apache/hadoop/hbase/client/example/MultiThreadedClientExample.java

https://www.google.com/

Je vous en ai déjà trop donné :)

## Un peu d'aide si vous ne trouvez vraiment pas

<details><summary>Je jure que j'ai essayé mais j'ai vraiment besoin d'aide</summary>
<p>

#### Pour démarrer

```java
Configuration config = HBaseConfiguration.create();

// Test Connection HBase
try {
    HBaseAdmin.checkHBaseAvailable(config);
    System.out.println(" OK HBASE");
} catch (Exception e) {
    e.printStackTrace();
    throw new RuntimeException("La connection n'est pas etablie: ", e);
}

final TableName tableName = TableName.valueOf(args[1]);

// Commencez avec ça
try (final Connection conn = ConnectionFactory.createConnection(config)){
  // A vous de jouer
} catch (IOException e) {
    e.printStackTrace();
    throw new RuntimeException("Erreur lors de la lecture du csv et insertion dans HBase: ", e);
}
```
</p>
</details>
